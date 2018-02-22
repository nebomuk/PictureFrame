#ifndef GOOGLECALENDARAUTHORIZATION_H
#define GOOGLECALENDARAUTHORIZATION_H

#include <QOAuth2AuthorizationCodeFlow>
#include <QObject>
#include <QQmlEngine>
#include "propertyhelper.h"

class GoogleCalendarAuthorization : public QObject
{

    Q_OBJECT
public:
    explicit GoogleCalendarAuthorization(QObject *parent = nullptr);

    static QObject *singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);


public slots:

    void startAuthorization();

signals:
    void granted();
    void failed();

private:
    QOAuth2AuthorizationCodeFlow * authorizationFlow;
};

#endif // GOOGLECALENDARAUTHORIZATION_H
