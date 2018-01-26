#include "mqtttest.h"
#include <qmqtt>

void MqttTest::initTestCase()
{

}

void MqttTest::cleanupTestCase()
{

}

MqttTest::MqttTest(QObject *parent) : QObject(parent)
{

    client =  new QMQTT::Client(QHostAddress::LocalHost, 1337,this);

}
