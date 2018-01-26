#ifndef CONTROLLERCONNECTIONMANAGERIMPL_H
#define CONTROLLERCONNECTIONMANAGERIMPL_H

#include "controllerdatacontainer.h"

#include <QObject>
#include <qmqtt_client.h>

class ControllerConnectionManagerImpl : public QObject
{
    Q_OBJECT
public:
    explicit ControllerConnectionManagerImpl(QString brokerAddress, ControllerDataContainer dataContainer, QObject *parent = nullptr);

     bool establishConnection(QString clientId);

     bool closeConnection();

     void publishSimpleStringMessage(QString path, QString simpleMessage);

     void publishJSONMessage(QString jsonObjectString, QString objectPath);


signals:

public slots:

private slots:
    void onConnected();

private:

    const int brokerPort = 1337;
    QMQTT::Client * client;
    QString currentClientId;
    ControllerDataContainer * dataContainer;
};

#endif // CONTROLLERCONNECTIONMANAGERIMPL_H
