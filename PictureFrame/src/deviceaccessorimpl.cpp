#include "deviceaccessorimpl.h"

#include "controllerconnectionconstants.h"
#include "controllerconnectionmanagerimpl.h"

#include <QJsonDocument>


DeviceAccessorImpl::DeviceAccessorImpl(QObject *parent) : QObject(parent), mIsConnectedToBroker(false)
{
    mControllerConnectionManager = new ControllerConnectionManagerImpl(this);
    connect(mControllerConnectionManager,&ControllerConnectionManagerImpl::published,this,&DeviceAccessorImpl::published);
    connect(mControllerConnectionManager,&ControllerConnectionManagerImpl::error,this,&DeviceAccessorImpl::error);


    this->mClientID = QUuid::createUuid().toString().mid(1, 36).toUpper();
}


bool DeviceAccessorImpl::isConnectedToBroker()
        {
            qDebug("FIXME this state is not updated");
            return mIsConnectedToBroker;
        }


quint16 DeviceAccessorImpl::sendCalendarImage(QJsonObject calendarImage)
{
    qDebug(__FUNCTION__);
    logJson(calendarImage, "calendarImage");
    calendarImage.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(calendarImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_CALENDAR_PATH);
}

quint16 DeviceAccessorImpl::sendWeatherImage(QJsonObject weatherImage)
{
    qDebug(__FUNCTION__);
    logJson(weatherImage, "weatherImage");
    weatherImage.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(weatherImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_WEATHER_PATH);
}

quint16 DeviceAccessorImpl::sendNewsImage(QJsonObject newsImage)
{
    qDebug(__FUNCTION__);
    logJson(newsImage, "newsImage");
    newsImage.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(newsImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_NEWSIMAGE_PATH);
}

quint16 DeviceAccessorImpl::sendFootballImage(QJsonObject footballImage)
{
    qDebug(__FUNCTION__);
    logJson(footballImage, "footballImage");
    footballImage.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(footballImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_FOOTBALL_PATH);
}

quint16 DeviceAccessorImpl::sendCinemaImage(QJsonObject cinemaImage)
{
    qDebug(__FUNCTION__);
    logJson(cinemaImage, "cinemaImage");
    cinemaImage.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(cinemaImage).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_CINEMA_PATH);
}

quint16 DeviceAccessorImpl::sendImageFile(QJsonObject imageFile)
{
    qDebug(__FUNCTION__);
    logJson(imageFile, "imageFile");
    imageFile.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(imageFile).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_IMAGEFILE_PATH);
}

quint16 DeviceAccessorImpl::sendCalendarBaseOptions(QJsonObject baseOptions)
{
    qDebug(__FUNCTION__);
    logJson(baseOptions, "baseOptions");
    baseOptions.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(baseOptions).toJson(), ControllerConnectionConstants::BASEOPTIONSPATH);
}

quint16 DeviceAccessorImpl::sendSmartCalendarDeviceOptions(QJsonObject deviceOptions)
{
    logJson(deviceOptions, "deviceOptions");
    deviceOptions.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(deviceOptions).toJson(), ControllerConnectionConstants::DEVICEOPTIONSPATH);
}

quint16 DeviceAccessorImpl::sendMasterAccount(QJsonObject masterAccount)
{
    qDebug(__FUNCTION__);
    logJson(masterAccount, "masterAccount");
    masterAccount.insert("clientID",this->mClientID);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(masterAccount).toJson(), ControllerConnectionConstants::MASTERACCOUNTPATH);
}

quint16 DeviceAccessorImpl::sendDefinedPersonsData(QJsonArray accountList)
{
    qDebug(__FUNCTION__);
    logJson(accountList, "accountList");
    QJsonArray modifiedAccounts=addClientID(accountList);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(accountList).toJson(), ControllerConnectionConstants::PERSONACCOUNTPATH);
}

quint16 DeviceAccessorImpl::sendBirthdayTable(QJsonArray birthdayList)
{
    qDebug(__FUNCTION__);
    logJson(birthdayList, "birthdayList");
    QJsonArray modifiedBirthdayList = addClientID(birthdayList);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(birthdayList).toJson(), ControllerConnectionConstants::BIRTHDAYPLANPATH);
}

quint16 DeviceAccessorImpl::sendTrashTable(QJsonArray trashList)
{
    qDebug(__FUNCTION__);
    logJson(trashList, "trashList");
    QJsonArray modifiedTrashList = addClientID(trashList);
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(trashList).toJson(), ControllerConnectionConstants::TRASHPLANPATH);
}


quint16 DeviceAccessorImpl::sendImageCount(int imageCount)
{
    qDebug(__FUNCTION__);
    logJson(imageCount, "imageCount");
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(QJsonObject {{"imageCount", imageCount}}).toJson(), ControllerConnectionConstants::IMAGEMESSAGE_IMAGE_Count);
}

quint16 DeviceAccessorImpl::sendDeviceLanguage(QString language)
{
    logJson(language, "language");
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(QJsonObject{{"language",language}}).toJson(), ControllerConnectionConstants::DEVICE_LANGUAGE);
}

quint16 DeviceAccessorImpl::sendCallBackAdress(QString callBackAddress)
{
    logJson(callBackAddress, "callBackAddress");
    this->mControllerConnectionManager->publishSimpleStringMessage(ControllerConnectionConstants::CALLBACKADRESSPATH, callBackAddress);
}

quint16 DeviceAccessorImpl::sendCalendarToken(QJsonObject refreshToken)
{
    logJson(refreshToken, "refreshToken");
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(refreshToken).toJson(), ControllerConnectionConstants::CALENDARTOKENPATH);
}

quint16 DeviceAccessorImpl::sendFirstConfigurationOption(QJsonObject firstConfigOption)
{
    logJson(firstConfigOption, "firstConfigOption");
    return this->mControllerConnectionManager->publishJSONMessage(QJsonDocument(firstConfigOption).toJson(), ControllerConnectionConstants::FIRSTCONFIGURATIONNETWORKPATH);
}

void DeviceAccessorImpl::clearLocalImageCache()
{
    this->mControllerConnectionManager->clearLocalImageCache();
}

void DeviceAccessorImpl::queryTrashPlan()
{
    this->mControllerConnectionManager->publishSimpleStringMessage(ControllerConnectionConstants::TRASHPLANREQUESTPATH, "Request Trashplan");
}

void DeviceAccessorImpl::queryBirthdayPlan()
{
    this->mControllerConnectionManager->publishSimpleStringMessage( ControllerConnectionConstants::BIRTHDAYPLANREQUESTPATH, "Request Birthdayplan");
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
    return this->mIsConnectedToBroker = mControllerConnectionManager->establishConnectionBlocking(brokerAddress,mClientID);
}

bool DeviceAccessorImpl::closeConnection()
{
    return mControllerConnectionManager->closeConnection();
}

void DeviceAccessorImpl::logJson(QVariant json,QString name)
{
    QString jsonString;
    if(json.canConvert<QJsonObject>())
    {
        QJsonDocument doc(json.value<QJsonObject>());
        jsonString = QString(doc.toJson());
    }
    else if(json.canConvert<QJsonArray>())
    {
        QJsonDocument doc(json.value<QJsonArray>());
        jsonString = QString(doc.toJson());
    }
    qDebug(qPrintable(name + ": " + jsonString));
}
