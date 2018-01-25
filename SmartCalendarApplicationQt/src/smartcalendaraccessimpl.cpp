#include "smartcalendaraccessimpl.h"

#include <QCoreApplication>
#include <QElapsedTimer>
#include <QHostAddress>
#include <QHostInfo>
#include <QNetworkDatagram>
#include <QNetworkInterface>
#include <QUdpSocket>

SmartCalendarAccessImpl::SmartCalendarAccessImpl(QObject *parent) : QObject(parent)
{

}

void SmartCalendarAccessImpl::CheckNetworkConnection()
{

    if ( IsConnectedToWifi())
    {
        IsConnected = true;
    }
    else if (IsCurrentlyRoaming()|| IsConnectedToActiveNetwork() )
    {
        IsConnected= false;
    }
    else
    {
        IsConnected = false;
    }

}

QList<QHostAddress> SmartCalendarAccessImpl::GetAllAvailableDevicesInNetwork()
{
    CheckNetworkConnection();

    if (!IsConnected)
    {
        return QList<QHostAddress>();
    }

    QNetworkInterface networkInterface;
    auto addresses =  networkInterface.allAddresses();
    return addresses;
}

bool IsConnectedToWifi()
{

    return true;
}

bool SmartCalendarAccessImpl::IsCurrentlyRoaming()
{
    return false;

}

QList<QHostAddress> SmartCalendarAccessImpl::GetControllerInNetworkFromBroadcast(int timeOut)
{
    QUdpSocket udpSocket;



    udpSocket.writeDatagram(BROADCASTMESSAGE.toLatin1(),QHostAddress::Broadcast,BROADCASTPORT);

    int RECEIVINGBROADCASTPORT = 3913;

    QUdpSocket receiver;
    receiver.bind(RECEIVINGBROADCASTPORT,QUdpSocket::ShareAddress);

     QElapsedTimer timer;
     timer.start();
    while(timer.elapsed() < timeOut && !receiver.hasPendingDatagrams())
    {
        QCoreApplication::processEvents();
    }

    QList<QHostAddress> resultAddresses;
    QByteArray datagram;
    while(receiver.hasPendingDatagrams())
    {
        datagram.resize(int(udpSocket.pendingDatagramSize()));
         udpSocket.readDatagram(datagram.data(), datagram.size());
         auto splitted = datagram.split(";");
         auto hostName = splitted[0];
         auto ipAddress = splitted[1];
         resultAddresses << QHostAddress(splitted[1]);

    }

    return resultAddresses;
}

QString SmartCalendarAccessImpl::GetCurrentTargetConnectionAddress()
{
    return "";
}

bool SmartCalendarAccessImpl::IsConnectedToActiveNetwork()
{
    return true;
}

bool SmartCalendarAccessImpl::IsConnectedToWifi()
{
    return true;
}
