#ifndef MQTTMESSAGEPARSER_H
#define MQTTMESSAGEPARSER_H

#include "controllerdatacontainer.h"

#include <qmqtt_message.h>



class MqttMessageParser
{
public:
    MqttMessageParser(ControllerDataContainer * dataContainer);

    void storeIncomingMessageLocally(QMQTT::Message msg);

    void storeSendingMessageLocally(QString subscriptionPath, QByteArray jsonString);
private:
    bool messageContainsSendingImage(QString topic);
    bool messageContainsIncomingImage(QString topic);
    void storeImage(QByteArray jsonString, QString topic);
    QJsonArray convertMessageToArray(QByteArray msg);

    ControllerDataContainer * mDataContainer;
};

#endif // MQTTMESSAGEPARSER_H
