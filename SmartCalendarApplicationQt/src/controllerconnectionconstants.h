#ifndef CONTROLLERCONNECTIONCONSTANTS_H
#define CONTROLLERCONNECTIONCONSTANTS_H

#include <QStringList>



namespace ControllerConnectionConstants
{

//Sending constants
        const QString TESTCONNECTIONPATH = "mqttdotnet/controller/test";

        const QString IMAGEMESSAGE_CALENDAR_PATH = "mqttdotnet/controller/image/calendarImage";
        const QString IMAGEMESSAGE_WEATHER_PATH = "mqttdotnet/controller/image/weatherImage";
        const QString IMAGEMESSAGE_NEWSIMAGE_PATH = "mqttdotnet/controller/image/newsImage";
        const QString IMAGEMESSAGE_FOOTBALL_PATH = "mqttdotnet/controller/image/footballImage";
        const QString IMAGEMESSAGE_CINEMA_PATH = "mqttdotnet/controller/image/cinemaImage";
        const QString IMAGEMESSAGE_IMAGEFILE_PATH = "mqttdotnet/controller/image/imageFile";
        const QString IMAGEMESSAGE_IMAGE_Count = "mqttdotnet/controller/image/imageCount";

        const QString DEVICEOPTIONSPATH = "mqttdotnet/controller/device/deviceOptions";
        const QString BASEOPTIONSPATH = "mqttdotnet/controller/device/baseOptions";
        const QString DEVICE_LANGUAGE = "mqttdotnet/controller/device/language";

        const QString MASTERACCOUNTPATH = "mqttdotnet/controller/account/masterAccount";
        const QString PERSONACCOUNTPATH = "mqttdotnet/controller/account/personAccount";
        const QString CALLBACKADRESSPATH = "mqttdotnet/controller/account/callBackAdress";

        const QString BIRTHDAYPLANPATH = "mqttdotnet/controller/plan/birthdayPlan";
        const QString TRASHPLANPATH = "mqttdotnet/controller/plan/trashPlan";

        const QString CALENDARTOKENPATH = "mqttdotnet/controller/token/calendarToken";

        const QString FIRSTCONFIGURATIONNETWORKPATH = "mqttdotnet/controller/firstConfiguration/networkAccessConfiguration";

        //Receiving constants
        const QString TESTSUBSCRIPTIONPATH = "mqttdotnet/client/test";
        const QString BIRTHDAYPLANSUBSCRIPTIONPATH = "mqttdotnet/client/plan/birthdayPlan";
        const QString TRASHPLANSUBSCRIPTIONPATH = "mqttdotnet/client/plan/trashPlan";
        const QString PERSONLISTSUBSCRIPTIONPATH = "mqttdotnet/client/list/personList";
        const QString BASEOPTIONSUBSCRIPTIONPATH = "mqttdotnet/client/option/baseOption";
        const QString DISPLAYOPTIONSUBSCRIPTIONPATH = "mqttdotnet/client/option/displayOption";

        const QString CALENDARIMAGESUBSCRIPTIONPATH = "mqttdotnet/client/image/calendarImage";
        const QString CINEMAIMAGESUBSCRIPTIONPATH = "mqttdotnet/client/image/cinemaImage";
        const QString FOOTBALLIMAGESUBSCRIPTIONPATH = "mqttdotnet/client/image/footballImage";
        const QString NEWSIMAGESUBSCRIPTIONPATH = "mqttdotnet/client/image/newsImage";
        const QString WEATHERIMAGESUBSCRIPTIONPATH = "mqttdotnet/client/image/weatherImage";
        const QString IMAGEFILESUBSCRIPTIONPATH = "mqttdotnet/client/image/imageFile";

        const QString FOOTBALLLEAGUESUBSCRIPTIONPATH = "mqttdotnet/client/image/football/league"; //Football leagues

        const QString FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/firstLeagueTeam"; //Football teams
        const QString SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/secondLeagueTeam";
        const QString SUPERLIGFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/superLigTeam";
        const QString LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/leagueOneTeam";
        const QString PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/premiereLeagueTeam";
        const QString SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/serieATeam";
        const QString LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/leagueBBVATeam";
        const QString EREDIVISIEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/eredivisieTeam";
        const QString PROLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/proLeagueTeam";
        const QString PRIMEIRALIGAFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/primeiraLigaTeam";
        const QString SUPERLIGAFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/superLigaTeam";
        const QString ALLSVENSKANFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/allsvenskanTeam";
        const QString SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/superLeagueTeam";
        const QString APFGFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/aPFGTeam";
        const QString FIRSTSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/1stLeagueTeam";
        const QString SYNOTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/synotLeagueTeam";
        const QString OTPBANKLIGAFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/OTPBANKLigaTeam";
        const QString EKSTRAKLASEFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/ekstraklasaTeam";
        const QString LIGAFIRSTCHAMPIOSCHIPFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/ligaI-championshipTeam";
        const QString PRIMERADIVFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/primeraDivTeam";
        const QString CSLPLAYOFFFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/cSLPlayOffTeam";
        const QString MLSFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/MLSTeam";
        const QString NASLFALLFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/NASLFallTeam";
        const QString USLPROFOOTBALLTEAMSUBSCRIPTIONPATH = "mqttdotnet/client/image/football/USLProTeam";

        //Requesting constants
        const QString BIRTHDAYPLANREQUESTPATH = "mqttdotnet/client/plan/birthdayPlan/request";
        const QString TRASHPLANREQUESTPATH = "mqttdotnet/client/plan/trashPlan/request";

        //Receiving constants in arrays as MQTT has a bug where you can not subribe to multiple paths at once!
        const QStringList TESTSUBSCRIPTIONPATHARRAY  { TESTSUBSCRIPTIONPATH };
        const QStringList BIRTHDAYPLANSUBSCRIPTIONPATHARRAY  { BIRTHDAYPLANSUBSCRIPTIONPATH };
        const QStringList TRASHPLANSUBSCRIPTIONPATHARRAY  { TRASHPLANSUBSCRIPTIONPATH };
        const QStringList PERSONLISTSUBSCRIPTIONPATHARRAY  { PERSONLISTSUBSCRIPTIONPATH };
        const QStringList BASEOPTIONSUBSCRIPTIONPATHARRAY  { BASEOPTIONSUBSCRIPTIONPATH };
        const QStringList DISPLAYOPTIONSUBSCRIPTIONPATHARRAY  { DISPLAYOPTIONSUBSCRIPTIONPATH };

        const QStringList CALENDARIMAGESUBSCRIPTIONPATHARRAY  { CALENDARIMAGESUBSCRIPTIONPATH };
        const QStringList CINEMAIMAGESUBSCRIPTIONPATHARRAY  { CINEMAIMAGESUBSCRIPTIONPATH };
        const QStringList FOOTBALLIMAGESUBSCRIPTIONPATHARRAY  { FOOTBALLIMAGESUBSCRIPTIONPATH };
        const QStringList NEWSIMAGESUBSCRIPTIONPATHARRAY  { NEWSIMAGESUBSCRIPTIONPATH };
        const QStringList WEATHERIMAGESUBSCRIPTIONPATHARRAY  { WEATHERIMAGESUBSCRIPTIONPATH };
        const QStringList IMAGEFILESUBSCRIPTIONPATHPATHARRAY  { IMAGEFILESUBSCRIPTIONPATH };

        const QStringList FOOTBALLLEAGUESUBSCRIPTIONPATHARRAY  { FOOTBALLLEAGUESUBSCRIPTIONPATH };

        const QStringList FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { FIRSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { SECONDLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList SUPERLIGFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { SUPERLIGFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { LEAGUEONEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { PREMIERELEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList SERIEALEAGUESUBSCRIPTIONPATHARRAY  { SERIEALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { LEAGUEBBVALEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList EREDIVISIEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { EREDIVISIEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList PROLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { PROLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList PRIMEIRALIGAFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { PRIMEIRALIGAFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList SUPERLIGAFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { SUPERLIGAFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList ALLSVENSKANFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { ALLSVENSKANFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { SUPERLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList APFGFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { APFGFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList FIRSTSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { FIRSTSTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList SYNOTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { SYNOTLEAGUEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList OTPBANKLIGAFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { OTPBANKLIGAFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList EKSTRAKLASEFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { EKSTRAKLASEFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList LIGAFIRSTCHAMPIOSCHIPFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { LIGAFIRSTCHAMPIOSCHIPFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList PRIMERADIVFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { PRIMERADIVFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList CSLPLAYOFFFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { CSLPLAYOFFFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList MLSFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { MLSFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList NASLFALLFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { NASLFALLFOOTBALLTEAMSUBSCRIPTIONPATH };
        const QStringList USLPROFOOTBALLTEAMSUBSCRIPTIONPATHARRAY  { USLPROFOOTBALLTEAMSUBSCRIPTIONPATH };
}

#endif // CONTROLLERCONNECTIONCONSTANTS_H
