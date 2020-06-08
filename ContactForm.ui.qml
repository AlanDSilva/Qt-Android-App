import QtQuick 2.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ItemDelegate {
    id: itemDelegate
    property alias name: name
    width: 100
    height: 40
    property alias editBtn: editBtn
    property alias deleteBtn: deleteBtn
    property alias mobileText: mobile.text
    property alias addressText: address.text
    property alias nameText: name.text

    Text {
        id: name

        text: "Text"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        visible: true
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 15
        font.bold: true
    }

    GridLayout {
        id: gridLayout
        height: 150
        rowSpacing: 3
        anchors.top: name.bottom
        anchors.horizontalCenterOffset: 10
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        rows: 3
        columns: 2

        Text {
            id: element1
            text: qsTr("Address")
            font.pixelSize: 12
        }

        Text {
            id: address
            text: qsTr("Text")
            font.pixelSize: 12
        }

        Text {
            id: element2
            text: qsTr("Mobile")
            font.pixelSize: 12
        }

        Text {
            id: mobile
            text: qsTr("Text")
            font.pixelSize: 12
        }

        Button {
            id: editBtn
            text: qsTr("Edit")
        }

        Button {
            id: deleteBtn
            text: qsTr("Dial")
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: itemDelegate.state == "clicked" ? itemDelegate.state
                                                     = "" : itemDelegate.state = "clicked"
    }
    states: [
        State {
            name: "clicked"

            PropertyChanges {
                target: gridLayout
                x: 0
                y: 21
                columnSpacing: 50
                rowSpacing: 5
                visible: true
            }

            PropertyChanges {
                target: itemDelegate

                height: 170
            }

            PropertyChanges {
                target: mouseArea
                anchors.rightMargin: 0
                anchors.bottomMargin: 45
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }

            PropertyChanges {
                target: deleteBtn
                hoverEnabled: false
                enabled: true
            }
        }
    ]
}

/*##^##
Designer {
    D{i:2;anchors_height:100}
}
##^##*/

