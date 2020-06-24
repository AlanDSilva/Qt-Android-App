import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

SwipeDelegate {
    id: itemDelegate
    width: 240
    height: 40

    //    property alias editBtn: editBtn
    //    property alias deleteBtn: deleteBtn
    text: firstname + " " + lastname

    GridLayout {
        id: gridLayout
        height: 150
        rowSpacing: 1
        anchors.horizontalCenterOffset: 10
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        rows: 3
        columns: 2

        Text {
            text: qsTr("Full Name")
            font.pixelSize: 12
        }

        Text {
            text: firstname + " " + lastname
            font.pixelSize: 12
        }

        Text {
            id: element1
            text: qsTr("Address")
            font.pixelSize: 12
        }

        Text {
            text: email
            font.pixelSize: 12
        }

        Text {
            id: element2
            text: qsTr("Mobile")
            font.pixelSize: 12
        }

        Text {
            text: mobile
            font.pixelSize: 12
        }

        //        Button {
        //            id: editBtn
        //            text: qsTr("Edit")
        //        }

        //        Button {
        //            id: deleteBtn
        //            text: qsTr("Dial")
        //        }
    }

    states: [
        State {
            name: "clicked"

            PropertyChanges {
                target: gridLayout
                x: 0
                y: 0
                columnSpacing: 50
                rowSpacing: 2
                visible: true
            }

            PropertyChanges {
                target: itemDelegate
                swipe.enabled: false
                swipe.position: 0

                text: ""

                height: 150
                display: AbstractButton.TextBesideIcon
            }
        }
    ]
}
