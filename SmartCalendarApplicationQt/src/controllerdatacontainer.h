#ifndef CONTROLLERDATACONTAINER_H
#define CONTROLLERDATACONTAINER_H

#include <QObject>
#include <QJsonValue>
#include <QJsonArray>
#include "propertyhelper.h"

class ControllerDataContainer : public QObject
{
    Q_OBJECT
public:
    explicit ControllerDataContainer(QObject *parent = nullptr);

private:

    AUTO_PROPERTY(QJsonValue,baseOptions)
    AUTO_PROPERTY(QJsonValue,smartCalendarDeviceOptionsDisplayOptions)


    AUTO_PROPERTY(QJsonArray, trashPlan)
    AUTO_PROPERTY(QJsonArray, birthdayPlan)
    AUTO_PROPERTY(QJsonArray, personList)
    AUTO_PROPERTY(QJsonArray, images)
    AUTO_PROPERTY(QJsonArray, footballLeagues)
    AUTO_PROPERTY(QJsonArray, firstLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, secondLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, superLigFootballTeams)
    AUTO_PROPERTY(QJsonArray, leagueOneLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, premiereLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, serialeLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, leagueBBVALeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, eredivisieFootballTeams)
    AUTO_PROPERTY(QJsonArray, superLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, proLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, primeiraLigaFootballTeams)
    AUTO_PROPERTY(QJsonArray, superligaFootballTeams)
    AUTO_PROPERTY(QJsonArray, allsvenskanFootballTeams)
    AUTO_PROPERTY(QJsonArray, apfgFootballTeams)
    AUTO_PROPERTY(QJsonArray, firststLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, synotLeagueFootballTeams)
    AUTO_PROPERTY(QJsonArray, otpBankLigaFootballTeams)
    AUTO_PROPERTY(QJsonArray, ekstraklaseFootballTeams)
    AUTO_PROPERTY(QJsonArray, ligaFirstChampioshipFootballTeams)
    AUTO_PROPERTY(QJsonArray, primeraDivisionFootballTeams)
    AUTO_PROPERTY(QJsonArray, cslPlayOffFootballTeams)
    AUTO_PROPERTY(QJsonArray, mlsFootballTeams)
    AUTO_PROPERTY(QJsonArray, naslFallFootballTeams)
    AUTO_PROPERTY(QJsonArray, uslProFootballTeams)


    AUTO_PROPERTY(bool,birthdayTableReceived)
    AUTO_PROPERTY(bool,trashTableReceived)
};

#endif // CONTROLLERDATACONTAINER_H
