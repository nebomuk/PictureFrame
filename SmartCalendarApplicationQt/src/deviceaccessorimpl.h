#ifndef DEVICEACCESSORIMPL_H
#define DEVICEACCESSORIMPL_H

#include "controllerconnectionmanagerimpl.h"

#include <QObject>
#include <QUuid>

class DeviceAccessorImpl : public QObject
{
    Q_OBJECT

    Q_PROPERTY(ControllerConnectionManagerImpl controllerConnectionManager READ controllerConnectionManager)

    Q_PROPERTY(bool isConnectedToBroker READ isConnectedToBroker)

public:
    explicit DeviceAccessorImpl(ControllerConnectionManagerImpl  *mControllerConnectionManager, QObject *parent = nullptr);


    ControllerConnectionManagerImpl *controllerConnectionManager() const;

public slots:

    bool isConnectedToBroker();
    void sendCalendarImage(QJsonObject calendarImage);

    void sendWeatherImage(QJsonObject weatherImage);
    void sendNewsImage(QJsonObject newsImage);
    void sendFootballImage(QJsonObject footballImage);
    void sendCinemaImage(QJsonObject cinemaImage);
    void sendImageFile(QJsonObject imageFile);
    void sendCalendarBaseOptions(QJsonObject baseOptions);
    void sendSmartCalendarDeviceOptions(QJsonObject deviceOptions);
    void sendMasterAccount(QJsonObject masterAccount);
    void sendDefinedPersonsData(QJsonArray accountList);
    void sendBirthdayTable(QJsonArray birthdayList);
    void sendTrashTable(QJsonArray trashList);
    void sendImageCount(int imageCount);
    void sendDeviceLanguage(QString language);
    void sendCallBackAdress(QString callBackAddress);
    void sendCalendarToken(QJsonObject refreshToken);
    void sendFirstConfigurationOption(QJsonObject firstConfigOption);
private:

    QJsonArray addClientID(QJsonArray jsonArray);


    ControllerConnectionManagerImpl  *mControllerConnectionManager;

    QString mClientID;
    bool mIsConnectedToBroker;



    void logJson(QVariant json, QString name);
};

#endif // DEVICEACCESSORIMPL_H
