#include "deviceaccessorimpl.h"

#include "controllerconnectionconstants.h"

#include <QJsonDocument>


DeviceAccessorImpl::DeviceAccessorImpl(ControllerConnectionManagerImpl *controllerConnectionManager, QObject *parent) : QObject(parent), isConnectedToBroker(false)
{
    controllerConnectionManager = controllerConnectionManager;

    this->clientID = QUuid::createUuid().toString().mid(1, 36).toUpper();
    this->isConnectedToBroker = controllerConnectionManager->establishConnection(clientID);
}


bool DeviceAccessorImpl::IsConnectedToBroker()
        {
            return isConnectedToBroker;
        }


void DeviceAccessorImpl::SendCalendarImage(QJsonObject calendarImage)
{
    logJson(calendarImage, "calendarImage");
    calendarImage.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(calendarImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_CALENDAR_PATH);
}

void DeviceAccessorImpl::SendWeatherImage(QJsonObject weatherImage)
{
    logJson(weatherImage, "weatherImage");
    weatherImage.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(weatherImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_WEATHER_PATH);
}

void DeviceAccessorImpl::SendNewsImage(QJsonObject newsImage)
{
    logJson(newsImage, "newsImage");
    newsImage.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(newsImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_NEWSIMAGE_PATH);
}

void DeviceAccessorImpl::SendFootballImage(QJsonObject footballImage)
{
    logJson(footballImage, "footballImage");
    footballImage.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(footballImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_FOOTBALL_PATH);
}

void DeviceAccessorImpl::SendCinemaImage(QJsonObject cinemaImage)
{
    logJson(cinemaImage, "cinemaImage");
    cinemaImage.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(cinemaImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_CINEMA_PATH);
}

void DeviceAccessorImpl::SendImageFile(QJsonObject imageFile)
{
    logJson(imageFile, "imageFile");
    imageFile.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(imageFile).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_IMAGEFILE_PATH);
}

void DeviceAccessorImpl::SendCalendarBaseOptions(QJsonObject baseOptions)
{
    logJson(baseOptions, "baseOptions");
    baseOptions.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(baseOptions).toJson(), ControllerConnectionConstants::BASEOPTIONSPATH);
}

void DeviceAccessorImpl::SendSmartCalendarDeviceOptions(QJsonObject deviceOptions)
{
    logJson(deviceOptions, "deviceOptions");
    deviceOptions.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(deviceOptions).toJson(), ControllerConnectionConstants::DEVICEOPTIONSPATH);
}

void DeviceAccessorImpl::SendMasterAccount(QJsonObject masterAccount)
{
    logJson(masterAccount, "masterAccount");
    masterAccount.insert("clientID",this->clientID);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(masterAccount).toJson(), ControllerConnectionConstants::MASTERACCOUNTPATH);
}

void DeviceAccessorImpl::SendDefinedPersonsData(QJsonArray accountList)
{
    logJson(accountList, "accountList");
    QJsonArray modifiedAccounts=addClientID(accountList);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(accountList).toJson(), ControllerConnectionConstants::PERSONACCOUNTPATH);
}

void DeviceAccessorImpl::SendBirthdayTable(QJsonArray birthdayList)
{
    logJson(birthdayList, "birthdayList");
    QJsonArray modifiedBirthdayList = addClientID(birthdayList);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(birthdayList).toJson(), ControllerConnectionConstants::BIRTHDAYPLANPATH);
}

void DeviceAccessorImpl::SendTrashTable(QJsonArray trashList)
{
    logJson(trashList, "trashList");
    QJsonArray modifiedTrashList = addClientID(trashList);
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(trashList).toJson(), ControllerConnectionConstants::TRASHPLANPATH);
}


void DeviceAccessorImpl::SendImageCount(int imageCount)
{
    logJson(imageCount, "imageCount");
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(QJsonObject {{"imageCount", imageCount}}).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_IMAGE_Count);
}

void DeviceAccessorImpl::SendDeviceLanguage(QString language)
{
    logJson(language, "language");
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(QJsonObject{{"language",language}}).toJson(), ControllerConnectionConstants::DEVICE_LANGUAGE);
}

void DeviceAccessorImpl::SendCallBackAdress(QString callBackAddress)
{
    logJson(callBackAddress, "callBackAddress");
    this->controllerConnectionManager->publishSimpleStringMessage(ControllerConnectionConstants::CALLBACKADRESSPATH, callBackAddress);
}

void DeviceAccessorImpl::SendCalendarToken(QJsonObject refreshToken)
{
    logJson(refreshToken, "refreshToken");
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(refreshToken).toJson(), ControllerConnectionConstants::CALENDARTOKENPATH);
}

void DeviceAccessorImpl::SendFirstConfigurationOption(QJsonObject firstConfigOption)
{
    logJson(firstConfigOption, "firstConfigOption");
    this->controllerConnectionManager->publishJSONMessage(QJsonDocument(firstConfigOption).toJson(), ControllerConnectionConstants::FIRSTCONFIGURATIONNETWORKPATH);
}

QJsonArray DeviceAccessorImpl::addClientID(QJsonArray jsonArray)
{
    QJsonArray newArray;
    for (const QJsonValue & value :  jsonArray) {
        QJsonObject obj = value.toObject();
        obj.insert("clientID",clientID);
        newArray.append(obj);
    }
    return newArray;
}

void DeviceAccessorImpl::logJson(QVariant json,QString name)
{
    qDebug(qPrintable(name + ": " + json.toString()));
}
