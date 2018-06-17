#ifndef MESSAGEHANDLER_H
#define MESSAGEHANDLER_H

#include <QObject>
#include <QVector>
#include <QtGlobal>
#include "propertyhelper.h"

/// replaces the default qt message handler via qInstallMessageHandler
/// only create one instance of this class
class MessageHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString cachedText READ cachedText)
    AUTO_PROPERTY(bool, redirectActive)

public:
    explicit MessageHandler(QObject *parent = nullptr);


    QString cachedText() const;


public slots:
    // installs a message handler into Qt that redirects all log output to cachedText()
    void installMessageHandlerRedirect();

private :
    void messageHandlerCallback(QtMsgType type, const QMessageLogContext &context, const QString &msg);

    QtMessageHandler defaultMessageHandler;

    static size_t count;
    static MessageHandler * instance;
    QVector<QString> cachedMessages;

};


#endif // MESSAGEHANDLER_H
