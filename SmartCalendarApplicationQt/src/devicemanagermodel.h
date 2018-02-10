#ifndef DEVICEMANAGERMODEL_H
#define DEVICEMANAGERMODEL_H

#include "smartcalendaraccessimpl.h"

#include <QObject>

/**
 * @brief The DeviceManagerModel class is the c++ backend model for the DeviceManagerPage.qml
 *  bind the availableDeviceCount etc. properties to the model property
 *  use the availableDeviceAt etc. properties in the delegate
 *
 */

class DeviceManagerModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int availableDeviceCount READ availableDeviceCount NOTIFY availableDevicesChanged)

    Q_PROPERTY(int savedDeviceCount READ savedDeviceCount NOTIFY savedDevicesChanged)

    Q_PROPERTY(QVariantList availableDevices READ availableDevicesVariantList NOTIFY availableDevicesChanged)

    Q_PROPERTY(QVariantList savedDevices READ savedDevicesVariantList NOTIFY savedDevicesChanged)


public:
    explicit DeviceManagerModel(QObject *parent = nullptr);

    void setAvailableDevices(const QList<ResponderClient> &availableDevices);

    void setSavedDevices(const QList<ResponderClient> &savedDevices);

    QList<ResponderClient> availableDevices() const;

    QList<ResponderClient> savedDevices() const;

    int availableDeviceCount() const;

    int savedDeviceCount() const;

    QVariantList availableDevicesVariantList() const;

    QVariantList savedDevicesVariantList() const;

    Q_INVOKABLE ResponderClient availableDeviceAt(int pos) { return mAvailableDevices.at(pos);}

    Q_INVOKABLE ResponderClient savedDeviceAt(int pos) { return mSavedDevices.at(pos);}


public slots:
    // this must be called to fill available devices
    void populateAvailableDevices();

signals:
    void availableDevicesChanged();
    void savedDevicesChanged();


private:
    // TODO replace with QQmlListProperty if notify does not work
    QList<ResponderClient> mAvailableDevices;
    QList<ResponderClient> mSavedDevices;

    SmartCalendarAccessImpl * mSmartcalendarAccess;

};

#endif // DEVICEMANAGERMODEL_H
