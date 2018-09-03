#ifndef GOOGLECALENDARAUTHORIZATION_H
#define GOOGLECALENDARAUTHORIZATION_H

#include "src/o2/o2google.h"
#include <QObject>
#include <QQmlEngine>
#include "propertyhelper.h"

class GoogleCalendarAuthorization : public QObject
{

    Q_PROPERTY(O2Google* o2 MEMBER mO2Google)

    Q_OBJECT
public:
    explicit GoogleCalendarAuthorization(QObject *parent = nullptr);

private slots:
    void onLinkedChanged();
    void onLinkingFailed();
    void onLinkingSucceeded();
    void onOpenBrowser(QUrl url);
    void onCloseBrowser();
private:
    O2Google * mO2Google;
};

#endif // GOOGLECALENDARAUTHORIZATION_H
