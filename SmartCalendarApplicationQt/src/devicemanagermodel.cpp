#include "devicemanagermodel.h"

DeviceManagerModel::DeviceManagerModel(QObject *parent) : QObject(parent)
{
    mSmartcalendarAccess = new SmartCalendarAccessImpl(this);

}

QStringList DeviceManagerModel::availableDevices() const
{
    return mAvailableDevices;
}

void DeviceManagerModel::setAvailableDevices(const QStringList &availableDevices)
{
    emit availableDevicesChanged();
    mAvailableDevices = availableDevices;
}

QStringList DeviceManagerModel::savedDevices() const
{
    return mSavedDevices;
}

void DeviceManagerModel::setSavedDevices(const QStringList &savedDevices)
{
    emit savedDevicesChanged();
    mSavedDevices = savedDevices;
}

void DeviceManagerModel::populateAvailableDevices()
{
    mSmartcalendarAccess->getControllerInNetworkFromBroadcast();
    connect(mSmartcalendarAccess,&SmartCalendarAccessImpl::controllerInNetworkReceived,this,&DeviceManagerModel::addAvailableDevices);
}

void DeviceManagerModel::addAvailableDevices(QList<ResponderClient> devices)
{
    // TODO make ResponderClient available to qml, notify
}
