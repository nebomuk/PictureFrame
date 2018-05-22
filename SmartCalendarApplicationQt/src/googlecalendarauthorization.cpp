#include "googlecalendarauthorization.h"

#include <QDesktopServices>
#include <QOAuthHttpServerReplyHandler>
#include <qoauth2authorizationcodeflow.h>
#include <QtDebug>


GoogleCalendarAuthorization::GoogleCalendarAuthorization(QObject *parent) : QObject(parent)
{
    mAuthorizationFlow = new QOAuth2AuthorizationCodeFlow(this);
    mAuthorizationFlow->setScope("https://www.googleapis.com/auth/calendar");
    connect(mAuthorizationFlow, &QOAuth2AuthorizationCodeFlow::authorizeWithBrowser,
        &QDesktopServices::openUrl);

    mAuthorizationFlow->setAuthorizationUrl(QUrl("https://accounts.google.com/o/oauth2/auth"));
    mAuthorizationFlow->setClientIdentifier("519174763143-12v9kv06h4rm6aehp67cfv3gg9gerji8.apps.googleusercontent.com");
    mAuthorizationFlow->setAccessTokenUrl(QUrl("https://accounts.googlew.com/o/oauth2/token"));
    mAuthorizationFlow->setClientIdentifierSharedKey("iVLAK5S6c5huXjgRCwdJ8OXl");

    QOAuthHttpServerReplyHandler * replyHandler = new QOAuthHttpServerReplyHandler(49517, this);
    replyHandler->setCallbackPath("Callback/");
    mAuthorizationFlow->setReplyHandler(replyHandler);

    connect(mAuthorizationFlow,&QOAuth2AuthorizationCodeFlow::statusChanged,this,[this](QOAuth2AuthorizationCodeFlow::Status status)
    {
        qDebug() << "authorizationFlow Calendar Authorization Status " + QString::number((int)status) + " received";
        qDebug() << "access token url" << mAuthorizationFlow->accessTokenUrl();
        qDebug() << "token " << mAuthorizationFlow->token();
        qDebug() << "refresh  token " << mAuthorizationFlow->refreshToken();
    });

    connect(mAuthorizationFlow,SIGNAL(granted()),this,SIGNAL(granted()));
    connect(mAuthorizationFlow,&QOAuth2AuthorizationCodeFlow::requestFailed,this,&GoogleCalendarAuthorization::failed);

    connect(this,&GoogleCalendarAuthorization::granted,this,[this]{
       qDebug() << "access token url" << mAuthorizationFlow->accessTokenUrl();
       qDebug() << "token " << mAuthorizationFlow->token();
       qDebug() << "refresh  token " << mAuthorizationFlow->refreshToken();
    });

}

QObject *GoogleCalendarAuthorization::singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    QObject * object = new GoogleCalendarAuthorization();
    return object;

}

QOAuth2AuthorizationCodeFlow *GoogleCalendarAuthorization::authorizationFlow() const
{
    return mAuthorizationFlow;
}

void GoogleCalendarAuthorization::startAuthorization()
{
    mAuthorizationFlow->grant();

}
