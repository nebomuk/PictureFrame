#ifndef OAUTH2AUTHORIZATION_H
#define OAUTH2AUTHORIZATION_H

#include <QOAuth2AuthorizationCodeFlow>
#include <QObject>
#include "propertyhelper.h"

class OAuth2Authorization : public QObject
{

    Q_OBJECT
public:
    explicit OAuth2Authorization(QObject *parent = nullptr);

public slots:

    void startGoogleCalendarAuthorization();

signals:
    void granted();
    void failed();

private:
    QOAuth2AuthorizationCodeFlow * authorizationFlow;
};

#endif // OAUTH2AUTHORIZATION_H
