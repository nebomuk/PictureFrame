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
                calendarImage = get(1).text
                weatherImage= get(2).text
                newsImage= get(3).text
                footballImage= get(4).text
                cinemaImage= get(5).text
                imageFile= get(6).text

                 populate()
            }
        }

        property string calendarImage
        property string weatherImage
        property string newsImage
        property string footballImage
        property string cinemaImage
        property string imageFile
    }


    function populate()
    {
        var footballImages = DeviceAccessor.controllerDataContainer.footballImages
        footballImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.footballImage,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var newsImages = DeviceAccessor.controllerDataContainer.newsImages
        newsImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.newsImage,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var imageFileImages = DeviceAccessor.controllerDataContainer.imageFileImages
        imageFileImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.imageFile,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var calendarImages = DeviceAccessor.controllerDataContainer.calendarImages
        calendarImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.calendarImage,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var weatherImages = DeviceAccessor.controllerDataContainer.weatherImages
        weatherImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.weatherImage,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        var cinemaImages = DeviceAccessor.controllerDataContainer.cinemaImages
        cinemaImages.forEach(function(img)
        {
            listModel.append({"pictureType":pictureTypeModel.cinemaImage,"displayTimeInSeconds":img.displayTimeInSeconds})
        })

        if(listModel.count === 0)
        {


        listModel.append({"pictureType":qsTr("Nothing Selected"),"displayTimeInSeconds":0})
        }
    }

    onListIndexClicked: {
        var item = listModel.get(index);
        dialog.setCurrentText(item.pictureType)
        dialog.open();
        dialog.indexOfItemCurrentlyEdited = index;

    }


    PictureTypeSelectionDialog
    {
        id : dialog

        property int indexOfItemCurrentlyEdited : -1

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2


        onAccepted: {
            if(indexOfItemCurrentlyEdited === -1)
            {
                return;
            }
            listModel.set(indexOfItemCurrentlyEdited,{"pictureType":tumbler.currentItem.text})

            openPage(tumbler.currentItem.text)
            indexOfItemCurrentlyEdited = -1;

        }
    }

    function openPage(pictureType)
    {
        var pageToOpen = "";
        switch(pictureType) {
            case pictureTypeModel.calendarImage:
                pageToOpen = "CalendarImagePage.qml"
                break;
            case pictureTypeModel.weatherImage:
                pageToOpen = "WeatherImagePage.qml"
                break;
            case pictureTypeModel.cinemaImage:
                pageToOpen = "CinemaImagePage.qml"
                break;
            case pictureTypeModel.newsImage:
                pageToOpen = "NewsImagePage.qml"
                break;
            case pictureTypeModel.footballImage:
                pageToOpen = "FootballImagePage.qml"
                break;
            case pictureTypeModel.imageFile:
                pageToOpen = "DynamicPicturePage.qml"
                break;
            default:
                console.error("No corresponding Page qml file found for picture Type " + pictureType)
                return;
        }

        var pushedPage =  stackView.push(pageToOpen);
        pushedPage.finished.connect(onPageFinished)
    }

    function onPageFinished(formData)
    {
        var currentPage = stackView.pop();
        currentPage.finished.disconnect(onPageFinished);


    }

}
