#include "simplesettings.h"
#include <QDebug>

SimpleSettings::SimpleSettings(QObject *parent) : QObject(parent)
{

}

QVariant SimpleSettings::value(const QString &key, const QVariant &defaultValue) const
{
     QVariant value = QSettings().value(key,defaultValue);

     // workaround for bool
         if (QString(value.typeName()) == "QString" &&
             (value.toString() == "false" || value.toString() == "true"))
             return QVariant(value.toBool());

   return value;
}

void SimpleSettings::setValue(const QString &key, const QVariant &value)
{

    qDebug() << "SimpleSettings::setValue key:" << key << "value:" << value;

    // workaround for bool
   if (QString(value.typeName()) == "QString" && value.toString() == "false")
   {
      QSettings().setValue(key,QVariant(false));
   }
   else if (QString(value.typeName()) == "QString" && value.toString() == "true")
   {
       QSettings().setValue(key,QVariant(true));
   }
   else
   {
       QSettings().setValue(key,value);
   }
}
