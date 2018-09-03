#ifndef LOGGINGFILTER_H
#define LOGGINGFILTER_H

#include <QObject>

/**
 * @brief The LoggingFilter class makes the QLoggingCategory.setFilterRules(const QString &rules)  accessible from qml
 */
class LoggingFilter : public QObject
{
    Q_OBJECT
public:
    explicit LoggingFilter(QObject *parent = nullptr);

signals:

public slots:
    void setFilterRules(const QString& rules);
};

#endif // LOGGINGFILTER_H
