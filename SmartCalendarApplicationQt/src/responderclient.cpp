#include "responderclient.h"


ResponderClient::ResponderClient()
{
    this->hostName = "";
    this->hostIpAdress = "";
}

ResponderClient::ResponderClient(QString hostName, QString hostIpAdress)
{
    this->hostName = hostName;
    this->hostIpAdress = hostIpAdress;
}

QString ResponderClient::GetHostName() const
{
    return this->hostName;
}

QString ResponderClient::GetHostIpAdress() const
{
    return this->hostIpAdress;
}

ResponderClient::operator QString() const
{
    return QString() + '(' + this->GetHostName() + ", " + this->GetHostIpAdress() + ')';
}
