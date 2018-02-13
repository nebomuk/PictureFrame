#include "devicemanagermodel.h"

#include <QTimer>


#include "qvariantlistconversion.h"

DeviceManagerModel::DeviceManagerModel(QObject *parent) : QObject(parent)
{
    mSmartcalendarAccess = new SmartCalendarAccessImpl(this);
    populateAvailableDevices();

    mSavedDevices.append(ResponderClient("Smart Calendar Thync 2","192.168.1.201"));
    mSavedDevices.append(ResponderClient("Smart Calendar Thync 3","192.168.1.202"));
}

QList<ResponderClient> DeviceManagerModel::availableDevices() const
{
    return mAvailableDevices;
}

void DeviceManagerModel::setAvailableDevices(const QList<ResponderClient> &availableDevices)
{
    mAvailableDevices = availableDevices;
    emit availableDevicesChanged();
}

QList<ResponderClient> DeviceManagerModel::savedDevices() const
{
    return mSavedDevices;
}

int DeviceManagerModel::availableDeviceCount() const { return mAvailableDevices.size(); }

int DeviceManagerModel::savedDeviceCount() const { return mSavedDevices.size(); }

QVariantList DeviceManagerModel::availableDevicesVariantList() const {
    return QVariantListConversion::toVariantList(availableDevices());
}

QVariantList DeviceManagerModel::savedDevicesVariantList() const
{
    return QVariantListConversion::toVariantList(savedDevices());
}

void DeviceManagerModel::setSavedDevices(const QList<ResponderClient> &savedDevices)
{
    mSavedDevices = savedDevices;
    emit savedDevicesChanged();
}

void DeviceManagerModel::populateAvailableDevices()
{
    mSmartcalendarAccess->getControllerInNetworkFromBroadcast();
    connect(mSmartcalendarAccess,&SmartCalendarAccessImpl::controllerInNetworkReceived,this,[=](QList<ResponderClient> controllers)
    {
        QList<ResponderClient> availableDevicesList;
        for(auto client : controllers)
        {
            availableDevicesList.append(client);
        }
        setAvailableDevices(availableDevicesList);
    });
}

