#include "messagehandler.h"
#include <QVector>

size_t MessageHandler::count = 0;
MessageHandler * MessageHandler::instance = nullptr;


MessageHandler::MessageHandler(QObject *parent) : QObject(parent)
{
    instance = this;

    count++;
    Q_ASSERT(count == 1); // only one instance allowed of this class

    redirectActive(false);

}

QString MessageHandler::cachedText() const
{
    return QStringList(cachedMessages.toList()).join("\n");

}

void MessageHandler::installMessageHandlerRedirect()
{
    qInstallMessageHandler([](QtMsgType type, const QMessageLogContext &context, const QString &msg)
    {
        instance->messageHandlerCallback(type,context,msg);
    });
    this->redirectActive(true);
}

void MessageHandler::messageHandlerCallback(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    if(defaultMessageHandler != nullptr)
    {
        //defaultMessageHandler(type,context,msg);
    }
    cachedMessages.append(">" + msg);
    if(cachedMessages.size() > 200)
    {
        cachedMessages.removeFirst();
    }
}


