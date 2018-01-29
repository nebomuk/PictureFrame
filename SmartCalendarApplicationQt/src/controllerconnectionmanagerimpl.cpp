#include "controllerconnectionmanagerimpl.h"

#include <QEventLoop>
#include <QJsonDocument>
#include <QJsonDocument>
#include <QTimer>
#include <qmqtt_message.h>
#include "controllerconnectionconstants.h"

ControllerConnectionManagerImpl::ControllerConnectionManagerImpl(QString brokerAddress, ControllerDataContainer * dataContainer, QObject *parent) : QObject(parent)
{
    this->dataContainer = dataContainer;

    client = new QMQTT::Client(brokerAddress,brokerPort,false, true,this);

    connect(client,&QMQTT::Client::error,this,&ControllerConnectionManagerImpl::onClientError);

    connect(client,&QMQTT::Client::received,this,&ControllerConnectionManagerImpl::listenToPublishes);
}

bool ControllerConnectionManagerImpl::establishConnection(QString clientId)
{
    client->setClientId(clientId);
    client->connectToHost();

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
    if(client->connectionState() == QMQTT::ConnectionState::STATE_DISCONNECTED)
    {
        registerSubscriptions();
        testConnection();
        currentClientId = clientId;
        qDebug("establishConnection successfull");
        return true;
    }
    else
    {
        qDebug("establishConnection failed: Connection timeout");
        return false;
    }

}

bool ControllerConnectionManagerImpl::closeConnection()
{
    if(client->connectionState() == QMQTT::ConnectionState::STATE_CONNECTED)
    {
        client->disconnectFromHost();
    }
    return true;
}

void ControllerConnectionManagerImpl::publishSimpleStringMessage(QString path, QString simpleMessage)
{
   QMQTT::Message message;
   message.setTopic(path);
   message.setPayload(simpleMessage.toUtf8());
    client->publish(message);
}

void ControllerConnectionManagerImpl::publishJSONMessage(QByteArray jsonObjectString, QString objectPath)
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
                   dataContainer->birthdayPlan(QJsonDocument::fromJson( msg.payload()).array());
                   dataContainer->birthdayTableReceived(true);
               }

    else if (ControllerConnectionConstants::TRASHPLANSUBSCRIPTIONPATH== msg.topic())
                {
                    dataContainer->trashPlan(convertMessageToArray(msg.payload()));
                    dataContainer->trashTableReceived(true);
                }
            else if (ControllerConnectionConstants::PERSONLISTSUBSCRIPTIONPATH== msg.topic())
            {
                dataContainer->personList(convertMessageToArray(msg.payload()));
            }
            else if (messageContainsIncomingImage(msg.topic()))
            {

                storeImage(msg.payload(), msg.topic());
            }
            else if (ControllerConnectionConstants::BASEOPTIONSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonObject baseOptions = QJsonDocument::fromJson(msg.payload()).object();
                dataContainer->baseOptions(baseOptions);
            }
            else if (ControllerConnectionConstants::DISPLAYOPTIONSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonObject displayOptions = QJsonDocument::fromJson(msg.payload()).object();
                dataContainer->smartCalendarDeviceOptionsDisplayOptions(displayOptions);
            }else if (ControllerConnectionConstants::FOOTBALLLEAGUESUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();;
                dataContainer->footballLeagues(receivedList);
            }
            else if (ControllerConnectionConstants::FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->firstLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->secondLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SUPERLIGFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->superLigFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->leagueOneLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->premiereLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->serialeLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->leagueBBVALeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::EREDIVISIEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->eredivisieFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PROLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->proLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PRIMEIRALIGAFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->primeiraLigaFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SUPERLIGAFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->superligaFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::ALLSVENSKANFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->allsvenskanFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->superLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::APFGFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->apfgFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::FIRSTSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->firstLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::SYNOTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->synotLeagueFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::OTPBANKLIGAFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->otpBankLigaFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::EKSTRAKLASEFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->ekstraklaseFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::LIGAFIRSTCHAMPIOSCHIPFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->ligaFirstChampioshipFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::PRIMERADIVFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->primeraDivisionFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::CSLPLAYOFFFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->cslPlayOffFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::MLSFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->cslPlayOffFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::NASLFALLFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->naslFallFootballTeams(receivedList);
            }
            else if (ControllerConnectionConstants::USLPROFOOTBALLTEAMSUBSCRIPTIONPATH== msg.topic())
            {

                QJsonArray receivedList = QJsonDocument::fromJson(msg.payload()).array();
                dataContainer->uslProFootballTeams(receivedList);
            }

}

void ControllerConnectionManagerImpl::storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString)
{

                if (ControllerConnectionConstants::BIRTHDAYPLANPATH== subscriptionPath)
                {
                    QJsonArray birthdayList=QJsonDocument::fromJson(jsonString).array();
                    dataContainer->birthdayPlan(birthdayList);
                    dataContainer->birthdayTableReceived(true);
                }
                else if (ControllerConnectionConstants::TRASHPLANPATH== subscriptionPath)
                {
                    QJsonArray trashList=QJsonDocument::fromJson(jsonString).array();
                    dataContainer->trashPlan(trashList);
                    dataContainer->trashTableReceived(true);
                }
                else if (ControllerConnectionConstants::PERSONACCOUNTPATH== subscriptionPath)
                {
                    QJsonArray personList=QJsonDocument::fromJson(jsonString).array();
                    QJsonArray oldPersonList = dataContainer->personList();
                    if (oldPersonList.size() > 0)
                    {
                        QJsonObject master = oldPersonList[0].toObject();
                        personList.insert(0,master);
                    }
                    dataContainer->personList(personList);
                }
                else if (ControllerConnectionConstants::MASTERACCOUNTPATH== subscriptionPath)
                {
                    QJsonObject masterAccount = QJsonDocument::fromJson(jsonString).object();
                    QJsonArray personList=dataContainer->personList();
                    if (personList.size() > 0)
                    {
                        personList[0]= masterAccount;
                    }else
                    {
                        personList.insert(0,masterAccount);
                    }
                    dataContainer->personList(personList);
                }
                else if (messageContainsSendingImage(subscriptionPath))
                {
                    storeImage(jsonString, subscriptionPath);
                }
                else if (ControllerConnectionConstants::BASEOPTIONSPATH== subscriptionPath)
                {
                    QJsonObject baseOptions = QJsonDocument::fromJson(jsonString).object();
                    dataContainer->baseOptions(baseOptions);
                }
                else if (ControllerConnectionConstants::DEVICEOPTIONSPATH== subscriptionPath)
                {
                    QJsonObject displayOptions = QJsonDocument::fromJson(jsonString).object();
                    dataContainer->smartCalendarDeviceOptionsDisplayOptions(displayOptions);
                }


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
            QJsonArray imageList = dataContainer->images();

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

            this->dataContainer->images(imageList);

}

QJsonArray ControllerConnectionManagerImpl::convertMessageToArray(QByteArray msg)
{
    return QJsonDocument::fromJson(msg).array();
}

void ControllerConnectionManagerImpl::onClientError(QMQTT::ClientError error)
{
    qDebug(qPrintable("FIXME: ClientError enum number " + QString::number(error) + " received"));
}



