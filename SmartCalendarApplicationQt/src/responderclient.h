#ifndef RESPONDERCLIENT_H
#define RESPONDERCLIENT_H

#include <QString>
#include <QtDebug>



class ResponderClient
{
public:


   ResponderClient(QString hostName, QString hostIpAdress);

   QString GetHostName() const;

   QString GetHostIpAdress() const;

   // for qDebug output
   operator QString() const;


 private:

    QString hostName;
   QString hostIpAdress;
};



#endif // RESPONDERCLIENT_H
