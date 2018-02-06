#include "devicemanagermodel.h"

DeviceManagerModel::DeviceManagerModel(QObject *parent) : QObject(parent)
{

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
