#include "mqttmessageparser.h"
#include "controllerconnectionconstants.h"

#include <QJsonDocument>

MqttMessageParser::MqttMessageParser(ControllerDataContainer * dataContainer)
{
    mDataContainer = dataContainer;
}

void MqttMessageParser::storeIncomingMessageLocally(QMQTT::Message msg)
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

void MqttMessageParser::storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString)
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

bool MqttMessageParser::messageContainsSendingImage(QString topic)
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

bool MqttMessageParser::messageContainsIncomingImage(QString topic)
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

void MqttMessageParser::storeImage(QByteArray jsonString, QString topic)
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

QJsonArray MqttMessageParser::convertMessageToArray(QByteArray msg)
{
   return QJsonDocument::fromJson(msg).array();
}
