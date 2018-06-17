import QtQuick 2.4
import de.vitecvisual.core 1.0;
import QtQuick.Controls 2.4;


DeveloperPageForm {

    buttonRedirectLog.onClicked:
    {
        buttonLogView.enabled = true;
        MessageHandler.installMessageHandlerRedirect()
        buttonRedirectLog.enabled = false;

    }

    buttonLogView.onClicked:
    {

        var cachedText = MessageHandler.cachedText;
        var comp = logPageComponent.createObject(stackView);

        comp.text = cachedText;
        stackView.push(comp);
    }

    Component.onCompleted:
    {
        buttonRedirectLog.enabled = !MessageHandler.redirectActive;
        buttonLogView.enabled = MessageHandler.redirectActive;

        checkBoxLoadQmlFromFs.checked = SimpleSettings.value("checkBoxLoadQmlFromFs",false);
    }

    checkBoxLoadQmlFromFs.onCheckedChanged:
    {
            SimpleSettings.setValue("checkBoxLoadQmlFromFs",checkBoxLoadQmlFromFs.checked);
            SimpleSettings.setValue("qmlFsPath",labelQmlFsPath.text);
    }

    Component
    {
        id : logPageComponent
        Page
        {
            id : logPage
            property string text
            TextArea {
                wrapMode: TextEdit.WrapAnywhere
                text : logPage.text
                id: textArea
                anchors.fill: parent
            }
        }
    }
}
