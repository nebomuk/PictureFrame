#ifndef ANDROIDEVENTDISPATCHER_H
#define ANDROIDEVENTDISPATCHER_H

#include <QMutex>
#include <QObject>
#include <QSemaphore>
#include <QtEventDispatcherSupport/private/qunixeventdispatcher_qpa_p.h>

class AndroidEventDispatcher : public QUnixEventDispatcherQPA
{
    Q_OBJECT
public:
    explicit AndroidEventDispatcher(QObject *parent = 0);
    ~AndroidEventDispatcher();
    void start();
    void stop();
    void goingToStop(bool stop);
protected:
    bool processEvents(QEventLoop::ProcessEventsFlags flags) override;
private:
    QAtomicInt m_stopRequest;
    QAtomicInt m_goingToStop;
    QSemaphore m_semaphore;

private slots:

    // emulates behaviour from androidjnimain.cpp
    // see https://code.woboq.org/qt5/qtbase/src/plugins/platforms/android/androidjnimain.cpp.html#685
    void updateApplicationState(Qt::ApplicationState state);
};
class AndroidEventDispatcherStopper
{
public:
    static AndroidEventDispatcherStopper *instance();
    static bool stopped() {return !instance()->m_started.load(); }
    void startAll();
    void stopAll();
    void addEventDispatcher(AndroidEventDispatcher *dispatcher);
    void removeEventDispatcher(AndroidEventDispatcher *dispatcher);
    void goingToStop(bool stop);
private:
    QMutex m_mutex;
    QAtomicInt m_started = 1;
    QVector<AndroidEventDispatcher *> m_dispatchers;
};



#endif // ANDROIDEVENTDISPATCHER_H
