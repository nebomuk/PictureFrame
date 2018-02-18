#ifndef MQTTCONNECTION_H
#define MQTTCONNECTION_H

#include <QObject>
#include <QTimer>
#include <qmqtt_client.h>

class MqttConnection : public QObject
{
    Q_OBJECT
public:
    explicit MqttConnection(const QString& brokerAddress, const QString& clientId,
                            QObject *parent = nullptr);

signals:
    void establishConnectionResult(bool isConnected);

public slots:

private slots:

    void onClientError();
    void onReceived();
    void onConnected();

    void resultTrue();

    void resultFalse();


private :
    QTimer  *timeout;
    QMQTT::Client * mClient;
    bool clientHasError();
};

#endif // MQTTCONNECTION_H
