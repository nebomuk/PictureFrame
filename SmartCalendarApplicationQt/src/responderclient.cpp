#include "responderclient.h"


ResponderClient::ResponderClient()
{
    this->mHostName = "";
    this->mHostIpAdress = "";
}

ResponderClient::ResponderClient(QString hostName, QString hostIpAdress)
{
    this->mHostName = hostName;
    this->mHostIpAdress = hostIpAdress;
}

QString ResponderClient::hostName() const
{
    return this->mHostName;
}

QString ResponderClient::hostIpAdress() const
{
    return this->mHostIpAdress;
}

ResponderClient::operator QString() const
{
    return QString() + '(' + this->hostName() + ", " + this->hostIpAdress() + ')';

}
