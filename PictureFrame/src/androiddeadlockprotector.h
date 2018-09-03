#ifndef ANDROIDDEADLOCKPROTECTOR_H
#define ANDROIDDEADLOCKPROTECTOR_H

#include <QAtomicInt>


class AndroidDeadlockProtector
{
public:
    AndroidDeadlockProtector()
        : m_acquired(0)
    {
    }
    ~AndroidDeadlockProtector() {
        if (m_acquired)
            s_blocked.storeRelease(0);
    }
    bool acquire() {
        m_acquired = s_blocked.testAndSetAcquire(0, 1);
        return m_acquired;
    }
private:
    static QAtomicInt s_blocked;
    int m_acquired;
};

QAtomicInt AndroidDeadlockProtector::s_blocked(0);


#endif // ANDROIDDEADLOCKPROTECTOR_H
