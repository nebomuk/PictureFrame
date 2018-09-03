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

ResponderClient::ResponderClient(QString hostName, QString hostIpAdress, QString productId, QString authToken)
{
    this->mHostName = hostName;
    this->mHostIpAdress = hostIpAdress;
    this->mProductId = productId;
this->mAuthToken = authToken;
}

QString ResponderClient::hostName() const
{
    return this->mHostName;
}

QString ResponderClient::hostIpAdress() const
{
    return this->mHostIpAdress;
}

QString ResponderClient::productId() const
{
    return mProductId;
}

QString ResponderClient::authToken() const
{
    return mAuthToken;
}

ResponderClient::operator QString() const
{
    return QString() + '(' + this->hostName() + ", " + this->hostIpAdress() + ')';

}
