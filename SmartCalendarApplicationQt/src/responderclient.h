#ifndef RESPONDERCLIENT_H
#define RESPONDERCLIENT_H

#include <QString>
#include <QtDebug>



class ResponderClient
{
public:

    // only used for meta object system
    ResponderClient();

   ResponderClient(QString hostName, QString hostIpAdress);

   QString GetHostName() const;

   QString GetHostIpAdress() const;

   // for qDebug output
   operator QString() const;


 private:

    QString hostName;
   QString hostIpAdress;
};

Q_DECLARE_METATYPE(ResponderClient)



#endif // RESPONDERCLIENT_H
