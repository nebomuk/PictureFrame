#include "loggingfilter.h"

#include <QLoggingCategory>

LoggingFilter::LoggingFilter(QObject *parent) : QObject(parent)
{

}

void LoggingFilter::setFilterRules(const QString &rules)
{
    QLoggingCategory::setFilterRules(rules);

}
