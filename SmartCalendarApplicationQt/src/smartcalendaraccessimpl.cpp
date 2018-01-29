#include "responderclient.h"
#include "smartcalendaraccessimpl.h"

#include <QCoreApplication>
#include <QElapsedTimer>
#include <QHostAddress>
#include <QHostInfo>
#include <QNetworkDatagram>
#include <QNetworkInterface>
#include <QTimer>
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

QList<ResponderClient> SmartCalendarAccessImpl::GetControllerInNetworkFromBroadcast(int timeOut)
{
    QUdpSocket senderSocket;



    senderSocket.writeDatagram(BROADCASTMESSAGE.toLatin1(),QHostAddress::Broadcast,BROADCASTPORT);

    int RECEIVINGBROADCASTPORT = 3913;

    QUdpSocket receiver;
    receiver.bind(RECEIVINGBROADCASTPORT,QUdpSocket::ShareAddress);

     QTimer timer;
     timer.setInterval(timeOut);
     timer.setSingleShot(true);
     QEventLoop eventLoop;
     connect(&timer,&QTimer::timeout,&eventLoop,&QEventLoop::quit);
     connect(&receiver,&QUdpSocket::readyRead,&eventLoop,&QEventLoop::quit);
     timer.start();
     eventLoop.exec();

    QList<ResponderClient> resultAddresses;
    QByteArray datagram;
    while(receiver.hasPendingDatagrams())
    {
        datagram.resize(int(receiver.pendingDatagramSize()));
         receiver.readDatagram(datagram.data(), datagram.size());
         auto splitted = datagram.split(';');
         auto hostName = splitted[0];
         QByteArray ipAddress = splitted[1];
         resultAddresses << ResponderClient(QString(hostName),QString(ipAddress));

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
