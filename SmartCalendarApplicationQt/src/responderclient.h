#ifndef RESPONDERCLIENT_H
#define RESPONDERCLIENT_H

#include <QString>
#include <QtDebug>



class ResponderClient
{
//    Q_GADGET

//    Q_PROPERTY(QString hostName READ hostName)

//    Q_PROPERTY(QString hostIpAdress READ hostIpAdress)

public:

    // only used for meta object system
    ResponderClient();

   ResponderClient(QString hostName, QString hostIpAdress);

   QString hostName() const;

   QString hostIpAdress() const;

   // for qDebug output
   operator QString() const;


 private:

    QString mHostName;
   QString mHostIpAdress;
};

Q_DECLARE_METATYPE(ResponderClient)



#endif // RESPONDERCLIENT_H
