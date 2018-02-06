#ifndef DEVICEMANAGERMODEL_H
#define DEVICEMANAGERMODEL_H

#include <QObject>

class DeviceManagerModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList availableDevices READ availableDevices WRITE setAvailableDevices NOTIFY availableDevicesChanged)
    Q_PROPERTY(QStringList savedDevices READ savedDevices WRITE setSavedDevices NOTIFY savedDevicesChanged)


public:
    explicit DeviceManagerModel(QObject *parent = nullptr);

    QStringList availableDevices() const;
    void setAvailableDevices(const QStringList &availableDevices);

    QStringList savedDevices() const;
    void setSavedDevices(const QStringList &savedDevices);

signals:
    void availableDevicesChanged();
    void savedDevicesChanged();

private:
    // TODO replace with QQmlListProperty if notify does not work
    QStringList mAvailableDevices;
    QStringList mSavedDevices;

};

#endif // DEVICEMANAGERMODEL_H
