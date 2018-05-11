import QtQuick 2.0
import de.vitecvisual.core 1.0

FootballImagePageForm {

    // sends json to CalendarMainPage
    signal finished(var formData);

    property var formData

    Component.onCompleted:
    {
        var dataContainer = DeviceAccessor.controllerDataContainer;
        comboBoxLeague.model = dataContainer.footballLeagues.concat().sort(function(a,b){
            return a.localeCompare(b);
        });

        var keys = Object.keys(formData);
        if(Object.keys(formData).length > 1)
        {
            comboBoxDesign.initialText = formData.design
            comboBoxTableFormat.initialText = formData.tableFormat
            comboBoxTeam.initialText = formData.team
            comboBoxLeague.initialText = formData.league
        }
    }

    buttonConfirm.onClicked:  {

        var formData = {};

        formData.tableFormat = comboBoxTableFormat.model.get(comboBoxTableFormat.currentIndex).key;
        formData.design = comboBoxDesign.currentText;
        formData.league = comboBoxLeague.currentText;
        formData.team = comboBoxTeam.currentText;

        finished(formData)
    }

    // when the league is selected, the available teams in the comboBoxTeam must change accordingly
    comboBoxLeague.onCurrentTextChanged:
    {
        onFootballLeagueSelected(comboBoxLeague.currentText)
    }

    function setTeamComboBoxModel(teams)
    {
        comboBoxTeam.model = teams.concat().sort(function(a,b){
            return a.localeCompare(b);
        });;
    }

    function onFootballLeagueSelected(selectedfootballLeague)
            {
                var dataContainer = DeviceAccessor.controllerDataContainer;

                if (selectedfootballLeague==="1. Bundesliga")
                {
                    setTeamComboBoxModel(dataContainer.firstLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="2. Bundesliga")
                {
                    setTeamComboBoxModel(dataContainer.secondLeagueFootballTeams);
                }else if(selectedfootballLeague==="1st League")
                {
                    setTeamComboBoxModel(dataContainer.firstStLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="A PFG")
                {
                    setTeamComboBoxModel(dataContainer.apfgLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Allsvenskan")
                {
                    setTeamComboBoxModel(dataContainer.allsvenskanFootballTeams);
                }
                else if (selectedfootballLeague==="CSL - Play - Off")
                {
                    setTeamComboBoxModel(dataContainer.cSLPlayOffFootballTeams);
                }
                else if (selectedfootballLeague==="Ekstraklasa")
                {
                    setTeamComboBoxModel(dataContainer.ekstraklasaLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Eredivisie")
                {
                    setTeamComboBoxModel(dataContainer.eredivisieFootballTeams);
                }
                else if (selectedfootballLeague==="Ligue 1")
                {
                    setTeamComboBoxModel(dataContainer.firstLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Liga BBVA")
                {
                    setTeamComboBoxModel(dataContainer.leagueBBVALeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Liga I- Championship")
                {
                    setTeamComboBoxModel(dataContainer.ligaFirstChampionshipFootballTeams);
                }
                else if (selectedfootballLeague==="MLS")
                {
                    setTeamComboBoxModel(dataContainer.mLSLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="NASL Fall")
                {
                    setTeamComboBoxModel(dataContainer.nASLFallLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="OTP Bank Liga")
                {
                    setTeamComboBoxModel(dataContainer.oTPBankLigaFootballTeams);
                }
                else if (selectedfootballLeague==="Premier League")
                {
                    setTeamComboBoxModel(dataContainer.premiereLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Serie A")
                {
                    setTeamComboBoxModel(dataContainer.serialeLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Super Lig")
                {
                    setTeamComboBoxModel(dataContainer.superLigFootballTeams);
                }
                else if (selectedfootballLeague==="Super League")
                {
                    setTeamComboBoxModel(dataContainer.superLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Pro League")
                {
                    setTeamComboBoxModel(dataContainer.proLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Primeira Liga")
                {
                    setTeamComboBoxModel(dataContainer.primeiraLigaFootballTeams);
                }
                else if (selectedfootballLeague==="Primera Div.")
                {
                    setTeamComboBoxModel(dataContainer.primeraDivisionLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="Superliga")
                {
                    setTeamComboBoxModel(dataContainer.superLigaFootballTeams);
                }
                else if (selectedfootballLeague==="Synot League")
                {
                    setTeamComboBoxModel(dataContainer.synotLeagueFootballTeams);
                }
                else if (selectedfootballLeague==="USL Pro")
                {
                    setTeamComboBoxModel(dataContainer.uSLProLeagueFootballTeams);
                }
                else
                {
                    console.error("No matching team found for league " + selectedfootballLeague);
                }
            }

}
