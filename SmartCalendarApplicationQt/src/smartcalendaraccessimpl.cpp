#include "qvariantlistconversion.h"
#include "responderclient.h"
#include "smartcalendaraccessimpl.h"

#include <QCoreApplication>
#include <QElapsedTimer>
#include <QHostAddress>
#include <QHostInfo>
#include <QNetworkConfigurationManager>
#include <QNetworkDatagram>
#include <QNetworkInterface>
#include <QTimer>
#include <QUdpSocket>

SmartCalendarAccessImpl::SmartCalendarAccessImpl(QObject *parent) : QObject(parent)
{
    auto manager = new QNetworkConfigurationManager(this);
    connect(manager,&QNetworkConfigurationManager::configurationChanged,this,&SmartCalendarAccessImpl::networkConfigurationChanged);
}

void SmartCalendarAccessImpl::checkNetworkConnection()
{

    if ( isConnectedToWifi())
    {
        mIsConnected = true;
    }
    else if (isCurrentlyRoaming()|| isConnectedToActiveNetwork() )
    {
        mIsConnected= false;
    }
    else
    {
        mIsConnected = false;
    }

}

QList<QHostAddress> SmartCalendarAccessImpl::getAllAvailableDevicesInNetwork()
{
    checkNetworkConnection();

    if (!mIsConnected)
    {
        return QList<QHostAddress>();
    }

    QNetworkInterface networkInterface;
    auto addresses =  networkInterface.allAddresses();
    return addresses;
}

bool SmartCalendarAccessImpl::isCurrentlyRoaming()
{
    // would require QNetworkSession https://stackoverflow.com/questions/24864092/test-a-local-connection-with-qt
    // which can be constructed using the QNetworkConfiguration, but is asynchronous

    return false;

}

QObject *SmartCalendarAccessImpl::singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    QObject *object = new SmartCalendarAccessImpl();
    return object;
}

QVariantList SmartCalendarAccessImpl::getControllerInNetworkFromBroadcastBlocking(int timeOut)
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

     QList<ResponderClient> resultAddresses = readResponderClientsFromUdpSocket(&receiver);

    return QVariantListConversion::toVariantList(resultAddresses);
}

QList<ResponderClient> SmartCalendarAccessImpl::readResponderClientsFromUdpSocket(QUdpSocket * socket)
{
    QList<ResponderClient> resultAddresses;
    QByteArray datagram;
    while(socket->hasPendingDatagrams())
    {
        datagram.resize(int(socket->pendingDatagramSize()));
         socket->readDatagram(datagram.data(), datagram.size());
         auto splitted = datagram.split(';');
         auto hostName = splitted[0];
         QByteArray ipAddress = splitted[1];
         resultAddresses << ResponderClient(QString(hostName),QString(ipAddress));

    }
    return resultAddresses;
}

void SmartCalendarAccessImpl::getControllerInNetworkFromBroadcast()
{
    QUdpSocket senderSocket;
    senderSocket.writeDatagram(BROADCASTMESSAGE.toLatin1(),QHostAddress::Broadcast,BROADCASTPORT);

    int RECEIVINGBROADCASTPORT = 3913;

    QUdpSocket * receiver = new QUdpSocket();
    receiver->bind(RECEIVINGBROADCASTPORT,QUdpSocket::ShareAddress);

    connect(receiver,&QUdpSocket::readyRead,this,[receiver,this]{
         QList<ResponderClient> resultAddresses = readResponderClientsFromUdpSocket(receiver);
         emit controllerInNetworkReceived(resultAddresses);
        receiver->deleteLater();
    });
}

QString SmartCalendarAccessImpl::getCurrentTargetConnectionAddress()
{
    return "";
}

bool SmartCalendarAccessImpl::isConnectedToActiveNetwork()
{
    QNetworkConfigurationManager manager;
    return !manager.allConfigurations(QNetworkConfiguration::Active).isEmpty();
}

bool SmartCalendarAccessImpl::isConnectedToWifi()
{
    QNetworkConfigurationManager manager;
    for(QNetworkConfiguration man : manager.allConfigurations(QNetworkConfiguration::Active))
    {
        if(man.bearerTypeFamily() == QNetworkConfiguration::BearerWLAN)
        {
            return true;
        }
    }
    return false;
}
