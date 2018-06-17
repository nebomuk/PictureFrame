#include "simplesettings.h"

SimpleSettings::SimpleSettings(QObject *parent) : QObject(parent)
{

}

QVariant SimpleSettings::value(const QString &key, const QVariant &defaultValue) const
{
    QSettings().value(key,defaultValue);
}

void SimpleSettings::setValue(const QString &key, const QVariant &value)
{
    QSettings().setValue(key,value);
}
