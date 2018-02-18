#ifndef MQTTCONNECTION_H
#define MQTTCONNECTION_H

#include <QObject>

class MqttConnection : public QObject
{
    Q_OBJECT
public:
    explicit MqttConnection(QObject *parent = nullptr);

signals:

public slots:
};

#endif // MQTTCONNECTION_H