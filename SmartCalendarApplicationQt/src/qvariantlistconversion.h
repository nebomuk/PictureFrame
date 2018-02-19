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

    template <typename T>
    static const QList<T> fromVariantList(const QVariantList& variantList )
    {
        QList<T> newList;
        for(QVariant variant : variantList)
        {
            newList.append(variant.value<T>());
        }

        return newList;
    }
};

#endif // QVARIANTLISTCONVERSION_H
