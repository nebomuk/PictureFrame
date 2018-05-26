#ifndef GOOGLECALENDARAUTHORIZATION_H
#define GOOGLECALENDARAUTHORIZATION_H

#include "src/o2/o2google.h"
#include <QObject>
#include <QQmlEngine>
#include "propertyhelper.h"

class GoogleCalendarAuthorization : public QObject
{

    Q_PROPERTY(O2Google* authorizationFlow MEMBER mAuthorizationFlow)

    Q_OBJECT
public:
    explicit GoogleCalendarAuthorization(QObject *parent = nullptr);

    static QObject *singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);

public slots:

    void startAuthorization();

signals:
    void granted();
    void failed();

private slots:
    void onLinkedChanged();
    void onLinkingFailed();
    void onLinkingSucceeded();
    void onOpenBrowser(QUrl url);
    void onCloseBrowser();
private:
    O2Google * mAuthorizationFlow;
};

#endif // GOOGLECALENDARAUTHORIZATION_H
