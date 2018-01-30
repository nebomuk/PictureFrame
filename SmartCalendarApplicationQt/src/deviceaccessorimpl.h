#ifndef DEVICEACCESSORIMPL_H
#define DEVICEACCESSORIMPL_H

#include "controllerconnectionmanagerimpl.h"

#include <QObject>
#include <QUuid>

class DeviceAccessorImpl : public QObject
{
    Q_OBJECT
public:
    explicit DeviceAccessorImpl(ControllerConnectionManagerImpl  *controllerConnectionManager, QObject *parent = nullptr);


public slots:

    bool IsConnectedToBroker();
    void SendCalendarImage(QJsonObject calendarImage);

    void SendWeatherImage(QJsonObject weatherImage);
    void SendNewsImage(QJsonObject newsImage);
    void SendFootballImage(QJsonObject footballImage);
    void SendCinemaImage(QJsonObject cinemaImage);
    void SendImageFile(QJsonObject imageFile);
    void SendCalendarBaseOptions(QJsonObject baseOptions);
    void SendSmartCalendarDeviceOptions(QJsonObject deviceOptions);
    void SendMasterAccount(QJsonObject masterAccount);
    void SendDefinedPersonsData(QJsonArray accountList);
    void SendBirthdayTable(QJsonArray birthdayList);
    void SendTrashTable(QJsonArray trashList);
    void SendImageCount(int imageCount);
    void SendDeviceLanguage(QString language);
    void SendCallBackAdress(QString callBackAddress);
    void SendCalendarToken(QJsonObject refreshToken);
    void SendFirstConfigurationOption(QJsonObject firstConfigOption);
private:

    QJsonArray addClientID(QJsonArray jsonArray);


    ControllerConnectionManagerImpl  *controllerConnectionManager;

    QString clientID;
    bool isConnectedToBroker;



    void logJson(QVariant json, QString name);
};

#endif // DEVICEACCESSORIMPL_H
