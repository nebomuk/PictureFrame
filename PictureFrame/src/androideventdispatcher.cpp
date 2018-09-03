#include "androideventdispatcher.h"
#include "androiddeadlockprotector.h"
#include <QGuiApplication>

AndroidEventDispatcher::AndroidEventDispatcher(QObject *parent) :
    QUnixEventDispatcherQPA(parent)
{

    connect(QGuiApplication::instance(),SIGNAL(applicationStateChanged(Qt::ApplicationState)),this,SLOT(updateApplicationState(Qt::ApplicationState)));

        AndroidEventDispatcherStopper::instance()->addEventDispatcher(this);
}
AndroidEventDispatcher::~AndroidEventDispatcher()
{
        AndroidEventDispatcherStopper::instance()->removeEventDispatcher(this);
}

enum States {Running = 0, StopRequest = 1, Stopping = 2};

void AndroidEventDispatcher::start()
{
    int prevState = m_stopRequest.fetchAndStoreAcquire(Running);
    if (prevState == Stopping) {
        m_semaphore.release();
        wakeUp();
    } else if (prevState == Running) {
        qWarning("Error: start without corresponding stop");
    }
    //else if prevState == StopRequest, no action needed
}
void AndroidEventDispatcher::stop()
{
    if (m_stopRequest.testAndSetAcquire(Running, StopRequest))
        wakeUp();
    else
        qWarning("Error: start/stop out of sync");
}
void AndroidEventDispatcher::goingToStop(bool stop)
{
    m_goingToStop.store(stop ? 1 : 0);
    if (!stop)
        wakeUp();
}
bool AndroidEventDispatcher::processEvents(QEventLoop::ProcessEventsFlags flags)
{
    if (m_goingToStop.load())
        flags |= QEventLoop::ExcludeSocketNotifiers | QEventLoop::X11ExcludeTimers;
    {
        AndroidDeadlockProtector protector;
        if (protector.acquire() && m_stopRequest.testAndSetAcquire(StopRequest, Stopping)) {
            m_semaphore.acquire();
            wakeUp();
        }
    }
    return QUnixEventDispatcherQPA::processEvents(flags);
}

void AndroidEventDispatcher::updateApplicationState(Qt::ApplicationState state)
{
    if (state <= Qt::ApplicationInactive) {
           // NOTE: sometimes we will receive two consecutive suspended notifications,
           // In the second suspended notification, QWindowSystemInterface::flushWindowSystemEvents()
           // will deadlock since the dispatcher has been stopped in the first suspended notification.
           // To avoid the deadlock we simply return if we found the event dispatcher has been stopped.
           if (AndroidEventDispatcherStopper::instance()->stopped())
               return;
           // Don't send timers and sockets events anymore if we are going to hide all windows
           AndroidEventDispatcherStopper::instance()->goingToStop(true);
           if (state == Qt::ApplicationSuspended)
               AndroidEventDispatcherStopper::instance()->stopAll();
       } else {
           AndroidEventDispatcherStopper::instance()->startAll();
           AndroidEventDispatcherStopper::instance()->goingToStop(false);
       }
}
AndroidEventDispatcherStopper *AndroidEventDispatcherStopper::instance()
{
    static AndroidEventDispatcherStopper androidEventDispatcherStopper;
    return &androidEventDispatcherStopper;
}
void AndroidEventDispatcherStopper::startAll()
{
    QMutexLocker lock(&m_mutex);
    if (!m_started.testAndSetOrdered(0, 1))
        return;
    for (AndroidEventDispatcher *d : qAsConst(m_dispatchers))
        d->start();
}
void AndroidEventDispatcherStopper::stopAll()
{
    QMutexLocker lock(&m_mutex);
    if (!m_started.testAndSetOrdered(1, 0))
        return;
    for (AndroidEventDispatcher *d : qAsConst(m_dispatchers))
        d->stop();
}
void AndroidEventDispatcherStopper::addEventDispatcher(AndroidEventDispatcher *dispatcher)
{
    QMutexLocker lock(&m_mutex);
    m_dispatchers.push_back(dispatcher);
}
void AndroidEventDispatcherStopper::removeEventDispatcher(AndroidEventDispatcher *dispatcher)
{
    QMutexLocker lock(&m_mutex);
    m_dispatchers.erase(std::find(m_dispatchers.begin(), m_dispatchers.end(), dispatcher));
}
void AndroidEventDispatcherStopper::goingToStop(bool stop)
{
    QMutexLocker lock(&m_mutex);
    for (AndroidEventDispatcher *d : qAsConst(m_dispatchers))
        d->goingToStop(stop);
}
