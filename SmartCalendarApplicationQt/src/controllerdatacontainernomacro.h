#ifndef CONTROLLERDATACONTAINERNOMACRO_H
#define CONTROLLERDATACONTAINERNOMACRO_H

#include <QJsonArray>
#include <QJsonValue>
#include <QObject>

class ControllerDataContainerNoMacro : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QJsonValue  baseOptions MEMBER baseOptions)
    Q_PROPERTY(QJsonValue  smartCalendarDeviceOptionsDisplayOptions MEMBER smartCalendarDeviceOptionsDisplayOptions)

    Q_PROPERTY(QJsonArray  trashPlan MEMBER trashPlan)
    Q_PROPERTY(QJsonArray  birthdayPlan MEMBER birthdayPlan)
    Q_PROPERTY(QJsonArray  personList MEMBER personList)
    Q_PROPERTY(QJsonArray  images MEMBER images)
    Q_PROPERTY(QJsonArray  footballLeagues MEMBER footballLeagues)
    Q_PROPERTY(QJsonArray  firstLeagueFootballTeams MEMBER firstLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  secondLeagueFootballTeams MEMBER secondLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  superLigFootballTeams MEMBER superLigFootballTeams)
    Q_PROPERTY(QJsonArray  leagueOneLeagueFootballTeams MEMBER leagueOneLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  premiereLeagueFootballTeams MEMBER premiereLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  serialeLeagueFootballTeams MEMBER serialeLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  leagueBBVALeagueFootballTeams MEMBER leagueBBVALeagueFootballTeams)
    Q_PROPERTY(QJsonArray  eredivisieFootballTeams MEMBER eredivisieFootballTeams)
    Q_PROPERTY(QJsonArray  superLeagueFootballTeams MEMBER superLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  proLeagueFootballTeams MEMBER proLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  primeiraLigaFootballTeams MEMBER primeiraLigaFootballTeams)
    Q_PROPERTY(QJsonArray  superligaFootballTeams MEMBER superligaFootballTeams)
    Q_PROPERTY(QJsonArray  allsvenskanFootballTeams MEMBER allsvenskanFootballTeams)
    Q_PROPERTY(QJsonArray  apfgFootballTeams MEMBER apfgFootballTeams)
    Q_PROPERTY(QJsonArray  firststLeagueFootballTeams MEMBER firststLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  synotLeagueFootballTeams MEMBER synotLeagueFootballTeams)
    Q_PROPERTY(QJsonArray  otpBankLigaFootballTeams MEMBER otpBankLigaFootballTeams)
    Q_PROPERTY(QJsonArray  ekstraklaseFootballTeams MEMBER ekstraklaseFootballTeams)
    Q_PROPERTY(QJsonArray  ligaFirstChampioshipFootballTeams MEMBER ligaFirstChampioshipFootballTeams)
    Q_PROPERTY(QJsonArray  primeraDivisionFootballTeams MEMBER primeraDivisionFootballTeams)
    Q_PROPERTY(QJsonArray  cslPlayOffFootballTeams MEMBER cslPlayOffFootballTeams)
    Q_PROPERTY(QJsonArray  mlsFootballTeams MEMBER mlsFootballTeams)
    Q_PROPERTY(QJsonArray  naslFallFootballTeams MEMBER naslFallFootballTeams)
    Q_PROPERTY(QJsonArray  uslProFootballTeams MEMBER uslProFootballTeams)

    Q_PROPERTY(bool birthdayTableReceived MEMBER birthdayTableReceived)
    Q_PROPERTY(bool trashTableReceived MEMBER trashTableReceived)



public:
    ControllerDataContainerNoMacro();

    QJsonValue baseOptions;
    QJsonValue smartCalendarDeviceOptionsDisplayOptions;


    QJsonArray trashPlan;
    QJsonArray birthdayPlan;
    QJsonArray personList;
    QJsonArray images;
    QJsonArray footballLeagues;
    QJsonArray firstLeagueFootballTeams;
    QJsonArray secondLeagueFootballTeams;
    QJsonArray superLigFootballTeams;
    QJsonArray leagueOneLeagueFootballTeams;
    QJsonArray premiereLeagueFootballTeams;
    QJsonArray serialeLeagueFootballTeams;
    QJsonArray leagueBBVALeagueFootballTeams;
    QJsonArray eredivisieFootballTeams;
    QJsonArray superLeagueFootballTeams;
    QJsonArray proLeagueFootballTeams;
    QJsonArray primeiraLigaFootballTeams;
    QJsonArray superligaFootballTeams;
    QJsonArray allsvenskanFootballTeams;
    QJsonArray apfgFootballTeams;
    QJsonArray firststLeagueFootballTeams;
    QJsonArray synotLeagueFootballTeams;
    QJsonArray otpBankLigaFootballTeams;
    QJsonArray ekstraklaseFootballTeams;
    QJsonArray ligaFirstChampioshipFootballTeams;
    QJsonArray primeraDivisionFootballTeams;
    QJsonArray cslPlayOffFootballTeams;
    QJsonArray mlsFootballTeams;
    QJsonArray naslFallFootballTeams;
    QJsonArray uslProFootballTeams;


    bool birthdayTableReceived;
    bool trashTableReceived;
};

#endif // CONTROLLERDATACONTAINERNOMACRO_H
