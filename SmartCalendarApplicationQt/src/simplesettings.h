#ifndef SIMPLESETTINGS_H
#define SIMPLESETTINGS_H

#include <QObject>
#include <QSettings>

///
/// \brief The SimpleSettings class is a simple wrapper around QSettings that can be used in QML
///
class SimpleSettings : public QObject
{
    Q_OBJECT
public:
    explicit SimpleSettings(QObject *parent = nullptr);

    Q_INVOKABLE
    QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;

public slots:
    void setValue(const QString &key, const QVariant &value);

};

#endif // SIMPLESETTINGS_H
