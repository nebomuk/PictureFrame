#include "deviceaccessorimpl.h"

#include "controllerconnectionconstants.h"
#include "controllerconnectionmanagerimpl.h"

#include <QJsonDocument>


DeviceAccessorImpl::DeviceAccessorImpl(QObject *parent) : QObject(parent), mIsConnectedToBroker(false)
{
    mControllerConnectionManager = new ControllerConnectionManagerImpl(this);

    this->mClientID = QUuid::createUuid().toString().mid(1, 36).toUpper();
}


bool DeviceAccessorImpl::isConnectedToBroker()
        {
            return mIsConnectedToBroker;
        }


void DeviceAccessorImpl::sendCalendarImage(QJsonObject calendarImage)
{
    logJson(calendarImage, "calendarImage");
    calendarImage.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(calendarImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_CALENDAR_PATH);
}

void DeviceAccessorImpl::sendWeatherImage(QJsonObject weatherImage)
{
    logJson(weatherImage, "weatherImage");
    weatherImage.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(weatherImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_WEATHER_PATH);
}

void DeviceAccessorImpl::sendNewsImage(QJsonObject newsImage)
{
    logJson(newsImage, "newsImage");
    newsImage.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(newsImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_NEWSIMAGE_PATH);
}

void DeviceAccessorImpl::sendFootballImage(QJsonObject footballImage)
{
    logJson(footballImage, "footballImage");
    footballImage.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(footballImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_FOOTBALL_PATH);
}

void DeviceAccessorImpl::sendCinemaImage(QJsonObject cinemaImage)
{
    logJson(cinemaImage, "cinemaImage");
    cinemaImage.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(cinemaImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_CINEMA_PATH);
}

void DeviceAccessorImpl::sendImageFile(QJsonObject imageFile)
{
    logJson(imageFile, "imageFile");
    imageFile.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(imageFile).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_IMAGEFILE_PATH);
}

void DeviceAccessorImpl::sendCalendarBaseOptions(QJsonObject baseOptions)
{
    logJson(baseOptions, "baseOptions");
    baseOptions.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(baseOptions).toJson(), ControllerConnectionConstants::BASEOPTIONSPATH);
}

void DeviceAccessorImpl::sendSmartCalendarDeviceOptions(QJsonObject deviceOptions)
{
    logJson(deviceOptions, "deviceOptions");
    deviceOptions.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(deviceOptions).toJson(), ControllerConnectionConstants::DEVICEOPTIONSPATH);
}

void DeviceAccessorImpl::sendMasterAccount(QJsonObject masterAccount)
{
    logJson(masterAccount, "masterAccount");
    masterAccount.insert("clientID",this->mClientID);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(masterAccount).toJson(), ControllerConnectionConstants::MASTERACCOUNTPATH);
}

void DeviceAccessorImpl::sendDefinedPersonsData(QJsonArray accountList)
{
    logJson(accountList, "accountList");
    QJsonArray modifiedAccounts=addClientID(accountList);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(accountList).toJson(), ControllerConnectionConstants::PERSONACCOUNTPATH);
}

void DeviceAccessorImpl::sendBirthdayTable(QJsonArray birthdayList)
{
    logJson(birthdayList, "birthdayList");
    QJsonArray modifiedBirthdayList = addClientID(birthdayList);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(birthdayList).toJson(), ControllerConnectionConstants::BIRTHDAYPLANPATH);
}

void DeviceAccessorImpl::sendTrashTable(QJsonArray trashList)
{
    logJson(trashList, "trashList");
    QJsonArray modifiedTrashList = addClientID(trashList);
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(trashList).toJson(), ControllerConnectionConstants::TRASHPLANPATH);
}


void DeviceAccessorImpl::sendImageCount(int imageCount)
{
    logJson(imageCount, "imageCount");
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(QJsonObject {{"imageCount", imageCount}}).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_IMAGE_Count);
}

void DeviceAccessorImpl::sendDeviceLanguage(QString language)
{
    logJson(language, "language");
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(QJsonObject{{"language",language}}).toJson(), ControllerConnectionConstants::DEVICE_LANGUAGE);
}

void DeviceAccessorImpl::sendCallBackAdress(QString callBackAddress)
{
    logJson(callBackAddress, "callBackAddress");
    this->mControllerConnectionManager->publishSimpleStringMessage(ControllerConnectionConstants::CALLBACKADRESSPATH, callBackAddress);
}

void DeviceAccessorImpl::sendCalendarToken(QJsonObject refreshToken)
{
    logJson(refreshToken, "refreshToken");
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(refreshToken).toJson(), ControllerConnectionConstants::CALENDARTOKENPATH);
}

void DeviceAccessorImpl::sendFirstConfigurationOption(QJsonObject firstConfigOption)
{
    logJson(firstConfigOption, "firstConfigOption");
    this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(firstConfigOption).toJson(), ControllerConnectionConstants::FIRSTCONFIGURATIONNETWORKPATH);
}

QJsonArray DeviceAccessorImpl::addClientID(QJsonArray jsonArray)
{
    QJsonArray newArray;
    for (const QJsonValue & value :  jsonArray) {
        QJsonObject obj = value.toObject();
        obj.insert("clientID",mClientID);
        newArray.append(obj);
    }
    return newArray;
}

ControllerDataContainer *DeviceAccessorImpl::controllerDataContainer() const
{
    return mControllerConnectionManager->dataContainer();
}

bool DeviceAccessorImpl::establishConnectionBlocking(const QString &brokerAddress)
{

    this->mIsConnectedToBroker = mControllerConnectionManager->establishConnectionBlocking(brokerAddress,mClientID);
}

bool DeviceAccessorImpl::closeConnection()
{
    mControllerConnectionManager->closeConnection();
}

void DeviceAccessorImpl::logJson(QVariant json,QString name)
{
    qDebug(qPrintable(name + ": " + json.toString()));
}
