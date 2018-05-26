#include "googlecalendarauthorization.h"

#include <QDesktopServices>
#include <QtDebug>
#include <QAbstractEventDispatcher>
#include <QCoreApplication>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

#include "src/o2/o0baseauth.h"


GoogleCalendarAuthorization::GoogleCalendarAuthorization(QObject *parent) : QObject(parent)
{    

    // file can be downloaded on https://console.developers.google.com

    QFile jsonFile(":/client_secret.json");
    if(!jsonFile.open(QFile::ReadOnly))
    {
        qWarning(":/client_secret.json resource file not found, oauth2 flow not possible");
        return;
    }
    QJsonDocument document = QJsonDocument::fromJson(jsonFile.readAll());

    const QJsonObject object = document.object();
    const QJsonObject settingsObject = object["web"].toObject();
    const QUrl authUri(settingsObject["auth_uri"].toString());
    const QString clientId = settingsObject["client_id"].toString();
    const QUrl tokenUri(settingsObject["token_uri"].toString());
    const QString clientSecret(settingsObject["client_secret"].toString());
    const QJsonArray redirectUris = settingsObject["redirect_uris"].toArray();
    const QUrl redirectUri(redirectUris[0].toString()); // Get the first URI
    const int port = static_cast<quint16>(redirectUri.port()); // Get the port


    mAuthorizationFlow = new O2Google(this);
    mAuthorizationFlow->setScope("https://www.googleapis.com/auth/calendar");
    mAuthorizationFlow->setClientId(clientId);
    mAuthorizationFlow->setClientSecret(clientSecret);
    QVariantMap map;
    map.insert("access_type",QVariant::fromValue(QString("offline")));
    mAuthorizationFlow->setExtraRequestParams(map);

    // causes QString::arg error message in O2 lib which can be ignored
    mAuthorizationFlow->setLocalhostPolicy(redirectUri.toString());

    mAuthorizationFlow->setLocalPort(port);

    const QByteArray html = QByteArrayLiteral("<html><head><title>") +
    QByteArrayLiteral("</title></head><body>") +
    "Successfull. You can close this page now and return to the app." +
    QByteArrayLiteral("</body></html>");
    mAuthorizationFlow->setReplyContent(html);


    connect(mAuthorizationFlow, &O0BaseAuth::linkedChanged, this, &GoogleCalendarAuthorization::onLinkedChanged);
    connect(mAuthorizationFlow, &O0BaseAuth::linkingFailed, this, &GoogleCalendarAuthorization::onLinkingFailed);
    connect(mAuthorizationFlow, &O0BaseAuth::linkingSucceeded, this, &GoogleCalendarAuthorization::onLinkingSucceeded);
    connect(mAuthorizationFlow, &O0BaseAuth::openBrowser, this, &GoogleCalendarAuthorization::onOpenBrowser);
    connect(mAuthorizationFlow, &O0BaseAuth::closeBrowser, this, &GoogleCalendarAuthorization::onCloseBrowser);
}

void GoogleCalendarAuthorization::onLinkedChanged()
{
qDebug() << __FUNCTION__;
}

void GoogleCalendarAuthorization::onLinkingFailed()
{
qDebug() << __FUNCTION__;
emit failed();

}

void GoogleCalendarAuthorization::onLinkingSucceeded()
{
qDebug() << __FUNCTION__;
qDebug() << "refresh token: " + mAuthorizationFlow->refreshToken();
qDebug() << "access token: " + mAuthorizationFlow->token();
emit granted();

}

void GoogleCalendarAuthorization::onOpenBrowser(QUrl url)
{
qDebug() << __FUNCTION__;

QDesktopServices::openUrl(url);

QAbstractEventDispatcher *dispatcher = QCoreApplication::instance()->eventDispatcher();
// if the manifest flag for background processing causes issues, we need to
// manually restart event processing
// see https://code.woboq.org/qt5/qtbase/src/plugins/platforms/android/qandroideventdispatcher.h.html#QAndroidEventDispatcher

}

void GoogleCalendarAuthorization::onCloseBrowser()
{
qDebug() << __FUNCTION__;

}

QObject *GoogleCalendarAuthorization::singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    QObject * object = new GoogleCalendarAuthorization();
    return object;

}

void GoogleCalendarAuthorization::startAuthorization()
{
    mAuthorizationFlow->unlink(); // for testing
    mAuthorizationFlow->link(); // checks internally if already linked
}
