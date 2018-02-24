import QtQuick 2.0
import de.vitecvisual.core 1.0

CalendarMainPageForm
{
    StringXmlResourceModel
    {
        attributeName : "imageSpinnerArray"
        id : pictureTypeModel

        // cannot populate in onCompleted because XmlListModel loads asynchronously
        onStatusChanged: {
            if(status === StringXmlResourceModel.Ready)
            {
                 populate()
            }
        }
    }


    function populate()
    {
        var footballImages = DeviceAccessor.controllerDataContainer.footballImages
        footballImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.get(4).text,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var newsImages = DeviceAccessor.controllerDataContainer.newsImages
        newsImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.get(3).text,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var imageFileImages = DeviceAccessor.controllerDataContainer.imageFileImages
        imageFileImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.get(6).text,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var calendarImages = DeviceAccessor.controllerDataContainer.calendarImages
        calendarImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.get(1).text,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var weatherImages = DeviceAccessor.controllerDataContainer.weatherImages
        weatherImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.get(2).text,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var cinemaImages = DeviceAccessor.controllerDataContainer.cinemaImages
        cinemaImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.get(5).text,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        if(listModel.count === 0)
        {


        listModel.append({"pictureType":qsTr("Nothing Selected"),"displayTimeInSeconds":0})
        }
    }

    onListIndexClicked: {
        var item = listModel.get(index);
        //dialog.tumbler.text = item.email
        dialog.open();
        dialog.indexOfItemCurrentlyEdited = index;

    }


    PictureTypeSelectionDialog
    {
        id : dialog

        property int indexOfItemCurrentlyEdited : -1


        onAccepted: {
            if(indexOfItemCurrentlyEdited === -1)
            {
                return;
            }
            listModel.set(indexOfItemCurrentlyEdited,{"pictureType":tumbler.model.get(tumbler.currentIndex).text})

            indexOfItemCurrentlyEdited = -1;

            //            target: comboBox
            //            onCurrentIndexChanged : {
            //                stackView.push(comboBox.model.get(comboBox.currentIndex).opensPage)
            //            }
            //        }


            //        model: ListModel
            //        {
            //                 ListElement { title : "No category selected"
            //                     opensPage : ""
            //                 }
            //                 ListElement { title : "Calendar image"
            //                    opensPage : "CalendarImagePage.qml"
            //                 }
            //                 ListElement { title : "Weather image"
            //                    opensPage : "WeatherImagePage.qml"
            //                 }
            //                 ListElement { title : "News image"
            //                    opensPage : "NewsImagePage.qml"
            //                 }
            //                 ListElement { title : "Football image"
            //                    opensPage : "FootballImagePage.qml"
            //                 }
            //                 ListElement { title : "Cinema image"
            //                    opensPage : "CinemaImagePage.qml"
            //                 }
            //                 ListElement { title : "Own image"
            //                    opensPage : ""
            //                 }

        }

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }

}
