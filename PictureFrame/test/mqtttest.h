#ifndef MQTTTEST_H
#define MQTTTEST_H

#include <QObject>
#include <QTest>
#include <qmqtt_client.h>


class MqttTest : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void connectToHostTest();
    void cleanupTestCase();

public:
    explicit MqttTest(QObject *parent = nullptr);

private:
    QMQTT::Client *client;

};

#endif // MQTTTEST_H
