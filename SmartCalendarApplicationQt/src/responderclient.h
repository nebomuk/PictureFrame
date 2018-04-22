#ifndef RESPONDERCLIENT_H
#define RESPONDERCLIENT_H

#include <QString>
#include <QtDebug>
#include <QObject>

 // requires qRegisterMetaType<ResponderClient>() (and not qmlRegisterType) to work in qml


class ResponderClient
{
    Q_GADGET

    Q_PROPERTY(QString hostName READ hostName)

    Q_PROPERTY(QString hostIpAdress READ hostIpAdress)

    Q_PROPERTY(QString productId READ productId)

    Q_PROPERTY(QString authToken READ authToken)

public:

    // only used for meta object system
    ResponderClient();

   ResponderClient(QString hostName, QString hostIpAdress);

   ResponderClient(QString hostName, QString hostIpAdress, QString productId, QString authToken);

   QString hostName() const;

   QString hostIpAdress() const;

   // for qDebug output
   operator QString() const;


   ResponderClient& operator=(ResponderClient other)
       {
           mHostName.swap(other.mHostName);
           mHostIpAdress.swap(other.mHostIpAdress);
           mProductId.swap(other.mProductId);
           mAuthToken.swap(other.mAuthToken);
           return *this;
       }

   QString productId() const;

   QString authToken() const;

private:

   QString mHostName;
   QString mHostIpAdress;

   QString mProductId;
   QString mAuthToken;
};

Q_DECLARE_METATYPE(ResponderClient)



#endif // RESPONDERCLIENT_H
