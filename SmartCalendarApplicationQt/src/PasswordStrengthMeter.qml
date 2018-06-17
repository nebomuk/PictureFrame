import QtQuick 2.5
import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ProgressBar {
    id: control
    
    property string password
    
    Component.onCompleted:
    {
        value = Qt.binding(function()
        {
            var hasNumber = /\d/;
            var res = 0.1;
            
            if(password.length < 8)
            {
                return res;
            }
            
            if(hasNumber.test(password))
            {
                res += 0.3;
            }
            var specialChar =  /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;
            if(specialChar.test(password))
            {
                res += 0.4;
            }
            
            if(password.length >=12)
            {
                res += 0.2
            }
            return res;
        });
    }
    
    value: 0.1
    padding: 2
    
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 6
        color: "#e6e6e6"
        radius: 3
    }
    
    contentItem: Item {
        implicitWidth: 200
        implicitHeight: 4
        
        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            radius: 2
            Component.onCompleted:
            {
                color = Qt.binding(function()
                {
                    if(control.value <= 0.1)
                    {
                        return "red";
                    }
                    else if(control.value <= 0.8)
                    {
                        return "yellow";
                    }
                    else
                    {
                        return "green";
                    }
                });
            }
        }
    }
}
