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


    mO2Google = new O2Google(this);
    mO2Google->setScope("https://www.googleapis.com/auth/calendar email"); // space intentional
    mO2Google->setClientId(clientId);
    mO2Google->setClientSecret(clientSecret);
    QVariantMap map;
    map.insert("access_type",QVariant::fromValue(QString("offline")));
    mO2Google->setExtraRequestParams(map);

    // causes QString::arg error message in O2 lib which can be ignored
    mO2Google->setLocalhostPolicy(redirectUri.toString());

    mO2Google->setLocalPort(port);

    const QByteArray html = QByteArrayLiteral("<html><head><title>") +
    QByteArrayLiteral("</title></head><body>") +
    "Successfull. You can close this page now and return to the app." +
    QByteArrayLiteral("</body></html>");
    mO2Google->setReplyContent(html);

    connect(mO2Google, &O0BaseAuth::linkedChanged, this, &GoogleCalendarAuthorization::onLinkedChanged);
    connect(mO2Google, &O0BaseAuth::linkingFailed, this, &GoogleCalendarAuthorization::onLinkingFailed);
    connect(mO2Google, &O0BaseAuth::linkingSucceeded, this, &GoogleCalendarAuthorization::onLinkingSucceeded);
    connect(mO2Google, &O0BaseAuth::openBrowser, this, &GoogleCalendarAuthorization::onOpenBrowser);
    connect(mO2Google, &O0BaseAuth::closeBrowser, this, &GoogleCalendarAuthorization::onCloseBrowser);
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
qDebug() << __FUNCTION__ << "note: signal emitted on linked/unlinked";
qDebug() << "refresh token: " + mO2Google->refreshToken();
qDebug() << "access token: " + mO2Google->token();
emit granted();

}

void GoogleCalendarAuthorization::onOpenBrowser(QUrl url)
{
qDebug() << __FUNCTION__;

QDesktopServices::openUrl(url);


// if the manifest flag for background processing causes issues, we need to
// manually restart event processing
// see https://code.woboq.org/qt5/qtbase/src/plugins/platforms/android/qandroideventdispatcher.h.html#QAndroidEventDispatcher

}

void GoogleCalendarAuthorization::onCloseBrowser()
{
qDebug() << __FUNCTION__;

}

void GoogleCalendarAuthorization::startAuthorization()
{
    qDebug() << "deprecated, call link by qml directly";
    //mAuthorizationFlow->link(); // checks internally if already linked
}
