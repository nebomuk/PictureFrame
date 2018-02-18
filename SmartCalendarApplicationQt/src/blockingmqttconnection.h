#ifndef BLOCKINGMQTTCONNECTION_H
#define BLOCKINGMQTTCONNECTION_H

#include <QFuture>
#include <QFutureWatcher>
#include <QObject>
#include <qmqtt_client.h>
#include <qmqtt_message.h>

/**
 * @brief The BlockingMqttConnection class handles mqtt connections and checks if the initial data has been received
 */

class BlockingMqttConnection : public QObject
{
    Q_OBJECT
    bool waitForMqttConnected();
    bool waitForInitialDataReceived();
public:
    explicit BlockingMqttConnection(QObject *parent = nullptr);

    bool establishConnectionBlocking(const QString &brokerAddress, const QString &clientId);

    void publish(QMQTT::Message msg);
    bool closeConnection();

    // simple QtConcurrent::run wrapper around establishConnectionBlocking, may not work, because some mqtt client internal objects are still in the wrong thread
    void establishConnection(QString brokerAddress, QString clientId);


signals:
    void establishConnectionResult(bool isEstablished);
    void received(QMQTT::Message msg);


public slots:

private slots:
    void onClientError(QMQTT::ClientError error);
private:
    QMQTT::Client *client;
    QString currentClientId;
    void testConnection();
    void registerSubscriptions();
    QMQTT::Client *createMqttClient(QString brokerAddress, int brokerPort);
    QFuture<bool> establishConnectionFuture;
    QFutureWatcher<bool> establishConnectionFutureWatcher;
};

#endif // BLOCKINGMQTTCONNECTION_H
