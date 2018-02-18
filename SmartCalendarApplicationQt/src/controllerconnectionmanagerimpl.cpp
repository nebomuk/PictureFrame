#include "controllerconnectionmanagerimpl.h"

#include <QEventLoop>
#include <QFutureWatcher>
#include <QJsonDocument>
#include <QJsonDocument>
#include <QPointer>
#include <QThreadPool>
#include <QTimer>
#include <QtConcurrent>
#include <qmqtt_message.h>
#include "controllerconnectionconstants.h"

ControllerConnectionManagerImpl::ControllerConnectionManagerImpl(QObject *parent) : QObject(parent)
{
    this->mDataContainer = new ControllerDataContainer(this);

    client = nullptr;

    qRegisterMetaType<QMQTT::Message>("QMQTT::Message");

    connect(&establishConnectionFutureWatcher,&QFutureWatcher<bool>::finished,this,[this]
    {
        emit establishConnectionResult(establishConnectionFuture.resultAt(0));
    });
}

bool ControllerConnectionManagerImpl::waitForMqttConnected()
{
    QTimer connectionTimeout;
    connectionTimeout.setInterval(3000);
    connectionTimeout.setSingleShot(true);
    QEventLoop eventLoop;

    connect(client,&QMQTT::Client::connected,&eventLoop,&QEventLoop::quit);
    connect(client,&QMQTT::Client::error,&eventLoop,&QEventLoop::quit);

    connect(&connectionTimeout,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
    connectionTimeout.start();
    eventLoop.exec();

    // connection state may still be INIT but DISCONNECTED when there was an error
    return client->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED;
}

bool ControllerConnectionManagerImpl::waitForInitialDataReceived()
{
    QTimer connectionTimeout;
    connectionTimeout.setInterval(3000);
    connectionTimeout.setSingleShot(true);

    bool initialDataReceived = false;

    QEventLoop eventLoop;

    connect(client,&QMQTT::Client::received,&eventLoop,[&eventLoop,&initialDataReceived]
    {
        initialDataReceived = true;
        eventLoop.quit();
    });
    connect(client,&QMQTT::Client::error,&eventLoop,&QEventLoop::quit);

    connect(&connectionTimeout,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
    connectionTimeout.start();
    eventLoop.exec();
    return initialDataReceived;
}

bool ControllerConnectionManagerImpl::establishConnectionBlocking(const QString& brokerAddress, const QString& clientId)
{
    delete client;
    client = createMqttClient(brokerAddress);

    client->setClientId(clientId);
    client->connectToHost();

    bool successfull = waitForMqttConnected();

    if(!successfull)
    {
        qDebug("establishConnection failed: Connection timeout");
        return false;
    }

    registerSubscriptions();
    testConnection(); // this will cause the receiving end to respond with the initial data

    bool initialDataReceived = waitForInitialDataReceived();
    if(!initialDataReceived)
    {
        qDebug("failed to receive initial Data");
        return false;
    }

    qDebug("initialDataReceived");
    currentClientId = clientId;
    return true;

}

void ControllerConnectionManagerImpl::establishConnection(QString brokerAddress,QString clientId)
{
    establishConnectionFuture = QtConcurrent::run([=]{
                  bool result =  establishConnectionBlocking(brokerAddress,clientId);
                  client->moveToThread(QCoreApplication::instance()->thread());
                  return result
    });
    establishConnectionFutureWatcher.setFuture(establishConnectionFuture);

}


bool ControllerConnectionManagerImpl::closeConnection()
{
    if(client->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED)
    {
        client->disconnectFromHost();
        client->deleteLater();
    }
    return true;
}

void ControllerConnectionManagerImpl::publishSimpleStringMessage(const QString& path, const QString& simpleMessage)
{
   QMQTT::Message message;
   message.setTopic(path);
   message.setPayload(simpleMessage.toUtf8());
    client->publish(message);
}

void ControllerConnectionManagerImpl::publishJSONMessage(const QByteArray& jsonObjectString, const QString& objectPath)
{
    QMQTT::Message message;
    message.setTopic(objectPath);
    message.setPayload(jsonObjectString);
    client->publish(message);
    storeSendingMessageLocally(objectPath,jsonObjectString);

}

void ControllerConnectionManagerImpl::registerSubscriptions()
{
    client->subscribe(ControllerConnectionConstants::TESTSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::BIRTHDAYPLANSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::TRASHPLANSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::PERSONLISTSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::BASEOPTIONSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::DISPLAYOPTIONSUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::CALENDARIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::CINEMAIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::FOOTBALLIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::NEWSIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::WEATHERIMAGESUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::IMAGEFILESUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::FOOTBALLLEAGUESUBSCRIPTIONPATH, 2);

    client->subscribe(ControllerConnectionConstants::FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
    client->subscribe(ControllerConnectionConstants::LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH, 2);
}

void ControllerConnectionManagerImpl::testConnection()
{
    QMQTT::Message message;
    message.setTopic(ControllerConnectionConstants::TESTCONNECTIONPATH);
    message.setPayload(QByteArray("Connection successfull"));
    client->publish(message);
}

void ControllerConnectionManagerImpl::listenToPublishes(QMQTT::Message msg)
{
    storeIncomingMessageLocally(msg);
}

void ControllerConnectionManagerImpl::storeIncomingMessageLocally(QMQTT::Message msg)
{
    if (ControllerConnectionConstants::BIRTHDAYPLANSUBSCRIPTIONPATH == msg.topic())
               {
                   mDataContainer->birthdayPlan(QJsonDocument::fromJson( msg.payload()).array());
                   mDataContainer->birthdayTableReceived(true);
               }

    else if (ControllerConnectionConstants::TRASHPLANSUBSCRIPTIONPATH== msg.topic())
                {
                    mDataContainer->trashPlan(convertMessageToArray(msg.payload()));
                    mDataContainer->trashTableReceived(true);
                }
            else if (ControllerConnectionConstants::PERSONLISTSUBSCRIPTIONPATH== msg.topic())
            {
                mDataContainer->personList(convertMessageToArray(msg.payload()));
            }
            else if (messageContainsIncomingImage(msg.topic()))
            {

                storeImage(msg.payload(), msg.topic());
            }
            else if (ControllerConnectionConstants::BASEOPTIONSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonObject baseOptions = QJsonDocument::fromJson(msg.payload()).object();
                mDataContainer->baseOptions(baseOptions);
            }
            else if (ControllerConnectionConstants::DISPLAYOPTIONSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonObject displayOptions = QJsonDocument::fromJson(msg.payload()).object();
                mDataContainer->smartCalendarDeviceOptionsDisplayOptions(displayOptions);
            }else if (ControllerConnectionConstants::FOOTBALLLEAGUESUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();;
                mDataContainer->footballLeagues(receivedList);
            }
            else if (ControllerConnectionConstants::FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->firstLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->secondLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SUPERLIGFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->superLigFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->leagueOneLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->premiereLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->serialeLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->leagueBBVALeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::EREDIVISIEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->eredivisieFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PROLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->proLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PRIMEIRALIGAFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->primeiraLigaFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SUPERLIGAFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->superligaFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::ALLSVENSKANFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->allsvenskanFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->superLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::APFGFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->apfgFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::FIRSTSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->firstLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SYNOTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->synotLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::OTPBANKLIGAFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->otpBankLigaFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::EKSTRAKLASEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->ekstraklaseFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::LIGAFIRSTCHAMPIOSCHIPFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->ligaFirstChampioshipFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PRIMERADIVFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->primeraDivisionFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::CSLPLAYOFFFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->cslPlayOffFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::MLSFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->cslPlayOffFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::NASLFALLFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->naslFallFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::USLPROFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                mDataContainer->uslProFootballTeams(receivedList);
            }

}

void ControllerConnectionManagerImpl::storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString)
{

                if (ControllerConnectionConstants::BIRTHDAYPLANPATH== subscriptionPath)
                {
                    QJsonArray birthdayList=QJsonDocument::fromJson(jsonString).array();
                    mDataContainer->birthdayPlan(birthdayList);
                    mDataContainer->birthdayTableReceived(true);
                }
                else if (ControllerConnectionConstants::TRASHPLANPATH== subscriptionPath)
                {
                    QJsonArray trashList=QJsonDocument::fromJson(jsonString).array();
                    mDataContainer->trashPlan(trashList);
                    mDataContainer->trashTableReceived(true);
                }
                else if (ControllerConnectionConstants::PERSONACCOUNTPATH== subscriptionPath)
                {
                    QJsonArray personList=QJsonDocument::fromJson(jsonString).array();
                    QJsonArray oldPersonList = mDataContainer->personList();
                    if (oldPersonList.size() > 0)
                    {
                        QJsonObject master = oldPersonList[0].toObject();
                        personList.insert(0,master);
                    }
                    mDataContainer->personList(personList);
                }
                else if (ControllerConnectionConstants::MASTERACCOUNTPATH== subscriptionPath)
                {
                    QJsonObject masterAccount = QJsonDocument::fromJson(jsonString).object();
                    QJsonArray personList=mDataContainer->personList();
                    if (personList.size() > 0)
                    {
                        personList[0]= masterAccount;
                    }else
                    {
                        personList.insert(0,masterAccount);
                    }
                    mDataContainer->personList(personList);
                }
                else if (messageContainsSendingImage(subscriptionPath))
                {
                    storeImage(jsonString, subscriptionPath);
                }
                else if (ControllerConnectionConstants::BASEOPTIONSPATH== subscriptionPath)
                {
                    QJsonObject baseOptions = QJsonDocument::fromJson(jsonString).object();
                    mDataContainer->baseOptions(baseOptions);
                }
                else if (ControllerConnectionConstants::DEVICEOPTIONSPATH== subscriptionPath)
                {
                    QJsonObject displayOptions = QJsonDocument::fromJson(jsonString).object();
                    mDataContainer->smartCalendarDeviceOptionsDisplayOptions(displayOptions);
                }


}

QMQTT::Client *ControllerConnectionManagerImpl::createMqttClient(QString brokerAddress)
{
    auto mqttClient = new QMQTT::Client(brokerAddress,brokerPort,false, true);

    connect(mqttClient,&QMQTT::Client::error,this,&ControllerConnectionManagerImpl::onClientError);

    connect(mqttClient,&QMQTT::Client::received,this,&ControllerConnectionManagerImpl::listenToPublishes);

    return mqttClient;
}

ControllerDataContainer *ControllerConnectionManagerImpl::dataContainer() const
{
    return mDataContainer;
}

 bool ControllerConnectionManagerImpl::messageContainsSendingImage(QString topic)
{
    if (ControllerConnectionConstants::IMAGEMESSAGE_CALENDAR_PATH== topic)
    {
        return true;
    }
    else if (ControllerConnectionConstants::IMAGEMESSAGE_WEATHER_PATH== topic)
    {
        return true;
    }
    else if (ControllerConnectionConstants::IMAGEMESSAGE_NEWSIMAGE_PATH== topic)
    {
        return true;
    }
    else if (ControllerConnectionConstants::IMAGEMESSAGE_FOOTBALL_PATH== topic)
    {
        return true;
    }
    else if (ControllerConnectionConstants::IMAGEMESSAGE_CINEMA_PATH== topic)
    {
        return true;
    }
    else if (ControllerConnectionConstants::IMAGEMESSAGE_IMAGEFILE_PATH== topic)
    {
        return true;
    }
    return false;
}

bool ControllerConnectionManagerImpl::messageContainsIncomingImage(QString topic)
 {
     if (ControllerConnectionConstants::CALENDARIMAGESUBSCRIPTIONPATH== topic){
         return true;
     }else if (ControllerConnectionConstants::CINEMAIMAGESUBSCRIPTIONPATH== topic)
     {
         return true;
     }
     else if (ControllerConnectionConstants::FOOTBALLIMAGESUBSCRIPTIONPATH== topic)
     {
         return true;
     }
     else if (ControllerConnectionConstants::NEWSIMAGESUBSCRIPTIONPATH== topic)
     {
         return true;
     }
     else if (ControllerConnectionConstants::WEATHERIMAGESUBSCRIPTIONPATH== topic)
     {
         return true;
     }
     else if (ControllerConnectionConstants::IMAGEFILESUBSCRIPTIONPATH== topic)
     {
         return true;
     }
     return false;
 }

void ControllerConnectionManagerImpl::storeImage(QByteArray jsonString, QString topic)
        {
            QJsonArray imageList = mDataContainer->images();

            if (ControllerConnectionConstants::CALENDARIMAGESUBSCRIPTIONPATH== topic|| ControllerConnectionConstants::IMAGEMESSAGE_CALENDAR_PATH== topic)
            {
                QJsonObject calendarImage = QJsonDocument::fromJson(jsonString).object();
                imageList.append(calendarImage);
            }
            else if (ControllerConnectionConstants::CINEMAIMAGESUBSCRIPTIONPATH== topic|| ControllerConnectionConstants::IMAGEMESSAGE_CINEMA_PATH== topic)
            {
                QJsonObject cinemaImage = QJsonDocument::fromJson(jsonString).object();
                imageList.append(cinemaImage);
            }
            else if (ControllerConnectionConstants::FOOTBALLIMAGESUBSCRIPTIONPATH== topic|| ControllerConnectionConstants::IMAGEMESSAGE_FOOTBALL_PATH== topic)
            {
                QJsonObject footballImage = QJsonDocument::fromJson(jsonString).object();
                imageList.append( footballImage);
            }
            else if (ControllerConnectionConstants::NEWSIMAGESUBSCRIPTIONPATH== topic|| ControllerConnectionConstants::IMAGEMESSAGE_NEWSIMAGE_PATH== topic)
            {
                QJsonObject newsImage = QJsonDocument::fromJson(jsonString).object();
                imageList.append( newsImage);
            }
            else if (ControllerConnectionConstants::WEATHERIMAGESUBSCRIPTIONPATH== topic|| ControllerConnectionConstants::IMAGEMESSAGE_WEATHER_PATH== topic)
            {
                QJsonObject weatherImage = QJsonDocument::fromJson(jsonString).object();
                imageList.append(weatherImage);
            }
            else if (ControllerConnectionConstants::IMAGEFILESUBSCRIPTIONPATH== topic|| ControllerConnectionConstants::IMAGEMESSAGE_IMAGEFILE_PATH== topic)
            {
                QJsonObject imageFile = QJsonDocument::fromJson(jsonString).object();
                imageList.append(imageFile);
            }

            this->mDataContainer->images(imageList);

}

QJsonArray ControllerConnectionManagerImpl::convertMessageToArray(QByteArray msg)
{
    return QJsonDocument::fromJson(msg).array();
}

void ControllerConnectionManagerImpl::onClientError(QMQTT::ClientError error)
{
    qDebug(qPrintable(QString("FIXME: ClientError enum enum %1 received").arg(error)));
}



