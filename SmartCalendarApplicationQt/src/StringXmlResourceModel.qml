import QtQuick 2.0
import QtQuick.XmlListModel 2.0


// a XmlListModel which reads android string xml resource file's <string-array name="attributeName"> <item>mystring</item></string-array> item elements
// combo box: textRole : "text"  and call Component.onCompleted: currentIndex = 0 in order to display the initial item properly
XmlListModel {

                property string attributeName

                source: "qrc:/Strings.xml"
                query: "/resources/string-array[@name=\'" + attributeName+  "\']/item"

                XmlRole { name: "text"; query: "string()" }

            }
