#ifndef MQTTCONNECTION_H
#define MQTTCONNECTION_H

#include <QObject>
#include <QTimer>
#include <qmqtt_client.h>
#include <qmqtt_message.h>

/**
 * @brief The MqttConnection class handles mqtt connections and checks if the initial data has been received
 *
 * this is an alternative implementation to BlockingMqttConnection
 */

class MqttConnection : public QObject
{
    Q_OBJECT
public:
    explicit MqttConnection(QObject *parent = nullptr);

    void publish(QMQTT::Message msg);
    bool closeConnection();

    void establishConnection(const QString& brokerAddress, const QString& clientId);
signals:
    void establishConnectionResult(bool isEstablished);
    void received(QMQTT::Message msg);

public slots:

private slots:

    void onClientError();
    void onReceived();
    void onConnected();

    void resultTrue();

    void resultFalse();


private :
    QList<QMetaObject::Connection*> mConnections;
    void disconnectAndDeleteConnections();
    QTimer  *timeout;
    QMQTT::Client * mClient;
    bool clientHasError();
    void registerSubscriptions();
    void testConnection();
};

#endif // MQTTCONNECTION_H
