#ifndef DEVICEMANAGERMODEL_H
#define DEVICEMANAGERMODEL_H

#include <QObject>

class DeviceManagerModel : public QObject
{
    Q_OBJECT
public:
    explicit DeviceManagerModel(QObject *parent = nullptr);

signals:

public slots:
};

#endif // DEVICEMANAGERMODEL_H