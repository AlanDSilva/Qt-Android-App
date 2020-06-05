import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.12

Row {

    property alias searchtext: searchtext
    property alias searchtextText: searchtext.text
    property alias resetSearchBtn: resetSearchBtn
    spacing: 20

    TextField {
        id: searchtext
        anchors.verticalCenter: parent.verticalCenter

        placeholderText: qsTr("Search...")

        Button {
            id: resetSearchBtn
            width: parent.width / 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            text: qsTr("X")
            //visible: searchtext.focus
            background: parent.color
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

