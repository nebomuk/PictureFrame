#ifndef BLOCKINGMQTTCONNECTION_H
#define BLOCKINGMQTTCONNECTION_H

#include <QFuture>
#include <QFutureWatcher>
#include <QObject>
#include <qmqtt_client.h>
#include <qmqtt_message.h>

/**
 * @brief The BlockingMqttConnection class handles mqtt connections and checks if the
 * first json object of the initial data has been received.
 * The client will continue to receive more initial data asynchronously
 */

class BlockingMqttConnection : public QObject
{
    Q_OBJECT
    bool waitForMqttConnected();
    bool waitForFirstJsonReceived();
public:
    explicit BlockingMqttConnection(QObject *parent = nullptr);

    bool establishConnectionBlocking(const QString &brokerAddress, const QString &clientId);

    quint16 publish(QMQTT::Message msg);
    bool closeConnection();

signals:
    void received(QMQTT::Message msg);
    void published(const QMQTT::Message& message, quint16 msgid = 0);


public slots:

private slots:
    void onClientError(QMQTT::ClientError error);
private:
    QMQTT::Client *client;
    QString currentClientId;
    void testConnection();
    void registerSubscriptions();
    QMQTT::Client *createMqttClient(QString brokerAddress, int brokerPort);
};

#endif // BLOCKINGMQTTCONNECTION_H
