#ifndef DEVICEACCESSORIMPL_H
#define DEVICEACCESSORIMPL_H

#include "controllerconnectionmanagerimpl.h"
#include "controllerdatacontainer.h"

#include <QObject>
#include <QUuid>

class DeviceAccessorImpl : public QObject
{
    Q_OBJECT

    //Q_PROPERTY(ControllerConnectionManagerImpl controllerConnectionManager READ controllerConnectionManager)

    Q_PROPERTY(ControllerDataContainer* controllerDataContainer READ controllerDataContainer CONSTANT /*supress qml warning*/)

    Q_PROPERTY(bool isConnectedToBroker READ isConnectedToBroker)

public:
    explicit DeviceAccessorImpl(QObject *parent = nullptr);

    ControllerDataContainer *controllerDataContainer() const;

    bool isConnectedToBroker();

signals:
    void published(const QMQTT::Message& message, quint16 msgid = 0);


public slots:

    bool establishConnectionBlocking(const QString &brokerAddress);
    bool closeConnection();

    quint16 sendCalendarImage(QJsonObject calendarImage);

    quint16 sendWeatherImage(QJsonObject weatherImage);
    quint16 sendNewsImage(QJsonObject newsImage);
    quint16 sendFootballImage(QJsonObject footballImage);
    quint16 sendCinemaImage(QJsonObject cinemaImage);
    quint16 sendImageFile(QJsonObject imageFile);
    quint16 sendCalendarBaseOptions(QJsonObject baseOptions);
    quint16 sendSmartCalendarDeviceOptions(QJsonObject deviceOptions);
    quint16 sendMasterAccount(QJsonObject masterAccount);
    quint16 sendDefinedPersonsData(QJsonArray accountList);
    quint16 sendBirthdayTable(QJsonArray birthdayList);
    quint16 sendTrashTable(QJsonArray trashList);
    quint16 sendImageCount(int imageCount);
    quint16 sendDeviceLanguage(QString language);
    quint16 sendCallBackAdress(QString callBackAddress);
    quint16 sendCalendarToken(QJsonObject refreshToken);
    quint16 sendFirstConfigurationOption(QJsonObject firstConfigOption);

    void clearLocalImageCache();

    void queryTrashPlan();

    void queryBirthdayPlan();

private:

    QJsonArray addClientID(QJsonArray jsonArray);


    ControllerConnectionManagerImpl  *mControllerConnectionManager;

    QString mClientID;
    bool mIsConnectedToBroker;



    void logJson(QVariant json, QString name);
};

#endif // DEVICEACCESSORIMPL_H
