#include "mqtttest.h"
#include <qmqtt>
#include <QTest>
#include <QDebug>
#include <QSignalSpy>

MqttTest::MqttTest(QObject *parent) : QObject(parent)
{



}
void MqttTest::initTestCase()
{
    client =  new QMQTT::Client(QHostAddress::LocalHost, 1337,this);

}

void MqttTest::connectToHostTest()
{
    client->connectToHost();

    QTimer connectionTimeout;
    connectionTimeout.setInterval(5000);
    connectionTimeout.setSingleShot(true);
    QEventLoop eventLoop;
    connect(client,&QMQTT::Client::error,&eventLoop,&QEventLoop::quit);
    connect(client,&QMQTT::Client::error,this,[=](const QMQTT::ClientError error)
    {
        qDebug() << "Received QMQTT::ClientError error enum " << error;
    });

    connect(client,&QMQTT::Client::connected,&eventLoop,&QEventLoop::quit);
    connect(&connectionTimeout,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
    connectionTimeout.start();
    eventLoop.exec();

    QVERIFY(client->connectionState() != QMQTT::ConnectionState::STATE_DISCONNECTED);
}

void MqttTest::cleanupTestCase()
{
    delete client;
}

