import QtQuick 2.0
import de.vitecvisual.core 1.0
import "DateUtil.js" as DateUtil

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
            insertSortedIntoListModel({"pictureType":pictureTypeModel.footballImage,
                                 "displayTimeInSeconds":img.displayTimeInSeconds,
                                 "formData":img})
             // {"":0,"":0} causes qml to store an QVariantList placeholder, which we can later overwrite
        })

        var newsImages = DeviceAccessor.controllerDataContainer.newsImages
        newsImages.forEach(function(img)
        {
            insertSortedIntoListModel({"pictureType":pictureTypeModel.newsImage,
                                 "displayTimeInSeconds":img.displayTimeInSeconds,
                             "formData":img})
        })

        var imageFileImages = DeviceAccessor.controllerDataContainer.imageFileImages
        imageFileImages.forEach(function(img)
        {
            insertSortedIntoListModel({"pictureType":pictureTypeModel.imageFile,
                                 "displayTimeInSeconds":img.displayTimeInSeconds,
                             "formData":img})
        })

        var calendarImages = DeviceAccessor.controllerDataContainer.calendarImages
        calendarImages.forEach(function(img)
        {
            insertSortedIntoListModel({"pictureType":pictureTypeModel.calendarImage,
                                 "displayTimeInSeconds":img.displayTimeInSeconds,
                             "formData":img})
        })

        var weatherImages = DeviceAccessor.controllerDataContainer.weatherImages
        weatherImages.forEach(function(img)
        {
            insertSortedIntoListModel({"pictureType":pictureTypeModel.weatherImage,
                                 "displayTimeInSeconds":img.displayTimeInSeconds,
                             "formData":img})
        })

        var cinemaImages = DeviceAccessor.controllerDataContainer.cinemaImages
        cinemaImages.forEach(function(img)
        {
            insertSortedIntoListModel({"pictureType":pictureTypeModel.cinemaImage,
                                 "displayTimeInSeconds":img.displayTimeInSeconds,
                             "formData":img})
        })

        if(listModel.count === 0)
        {


        listModel.append({"pictureType":qsTr("Nothing Selected"),"displayTimeInSeconds":0})
        }
    }

    // uses insertion sort algo and the index from the formData to insert it into the list
    // so that the list items' order corresponds to the formData.index indices
    function insertSortedIntoListModel(json)
    {

        var inputIndex = json.formData.index;
        for(var i = 0; i< listModel.count; ++i)
        {
            if(listModel.get(i).formData.index >= inputIndex)
            {
                listModel.insert(i,json);
                return;
            }
        }
        listModel.append(json);
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
            // in the tumbler, a different picture type may has been selected from the one on the button that opens the tumbler
            var pictureTypeHasChanged = listModel.get(indexOfItemCurrentlyEdited).pictureType !== tumbler.currentItem.text

            listModel.set(indexOfItemCurrentlyEdited,{"pictureType":tumbler.currentItem.text})

            // picture type has changed, no initial properties for the ImagePage
            if(pictureTypeHasChanged)
            {
                openPage(tumbler.currentItem.text,
                         indexOfItemCurrentlyEdited,
                         {"":0}) // empty QVariantMap
            }
            else // picture type has not changed, push initial properties (formData) to the ImagePage
            {
                openPage(tumbler.currentItem.text,
                         indexOfItemCurrentlyEdited,
                         listModel.get(indexOfItemCurrentlyEdited).formData)
            }

            indexOfItemCurrentlyEdited = -1;

        }
    }

    function openPage(pictureType, index, formData)
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

        var pushedPage =  stackView.push(pageToOpen,{"index":index, "formData":formData});
        pushedPage.finished.connect(onPageFinished)
    }

    function onPageFinished(formData)
    {
        var currentPage = stackView.pop();
        currentPage.finished.disconnect(onPageFinished);
        var item = listModel.get(currentPage.index)
        item.formData = formData;
        listModel.set(currentPage.index,item); // setProperty would not work here because it takes a variant

        // list model item is now of the following structure
        // {
        //      displayTimeInSeconds : 20
        //      formData : {
        //                  design : "someDesign"
        //                      ...
        //                  }
        //      pictureType : calendarImage
        // }

    }

    buttonConfirm.onClicked: {

        for(var i = 0; i < listModel.count; ++i)
        {
            var formData = listModel.get(i).formData;
            var jsonObject = {};

            // write form data (image type specific properties) into jsonObject
            for (var prop in formData) {
                if (formData.hasOwnProperty(prop))
                {
                    jsonObject[prop] = formData[prop]
                }
            }
            jsonObject.displayTimeInSeconds = listModel.get(i).displayTimeInSeconds;
            jsonObject.totalImageCount = listModel.count;
            jsonObject.index = i;
            jsonObject.publishTimeStamp = DateUtil.toShortISOString(new Date());
            jsonObject.clientID = "test_client42"

            switch(listModel.get(i).pictureType)
            {
                case pictureTypeModel.calendarImage:
                    DeviceAccessor.sendCalendarImage(jsonObject);
                    break;
                case pictureTypeModel.weatherImage :
                    DeviceAccessor.sendWeatherImage(jsonObject);
                    break;
                case pictureTypeModel.newsImage    :
                    DeviceAccessor.sendNewsImage(jsonObject);
                    break;
                case pictureTypeModel.footballImage:
                    DeviceAccessor.sendFootballImage(jsonObject);
                    break;
                case pictureTypeModel.cinemaImage  :
                    DeviceAccessor.sendCinemaImage(jsonObject);
                    break;
                case pictureTypeModel.imageFile    :
                    DeviceAccessor.sendImageFile(jsonObject);
                    break;
            }
        }
        listModel.clear();
        stackView.pop();
        // FIXME, transaction when storing images? should not overwrite old ControllerDataContainer immediately but only part of it
        // 2 possibilities: use SQLite in memory :memory: database or overwrite old instance of ControllerDataContainer with new one
        // when the transaction finished (simpler)
    }



}
