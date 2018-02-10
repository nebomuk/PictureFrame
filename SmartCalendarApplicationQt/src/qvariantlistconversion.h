#ifndef QVARIANTLISTCONVERSION_H
#define QVARIANTLISTCONVERSION_H

#include <QVariantList>



class QVariantListConversion
{
public:
    QVariantListConversion() = delete;

    template <typename T>
    static QVariantList toVariantList( const QList<T> &list )
    {
        QVariantList newList;
        foreach( const T &item, list )
            newList.append(QVariant::fromValue(item));

        return newList;
    }
};

#endif // QVARIANTLISTCONVERSION_H
