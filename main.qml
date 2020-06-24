import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.LocalStorage 2.12
import "request.js" as Request
import "database.js" as DB
import "sync.js" as Sync

import MyLib 1.0


ApplicationWindow {
    visible: true
    width: 360
    height: 520
    title: qsTr("Contact List")

    Component.onCompleted: {
        Request.getContacts2()
        DB.dbInit()
        DB.dbGetAll()
//        Sync.getNewContact()
    }

    OpenDial{
        id: dial
    }

    Drawer {
        id: drawer
        width: Math.min(parent.width, parent.height) / 3 * 2
        height: parent.height
        DrawerMenu{}
    }

    header: ToolBar {
        Material.background: Material.Pink

        ToolButton {
            id: menuButton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "images/baseline-menu-24px.svg"
            onClicked: drawer.open()
        }

        Switch {
            id: switcher
            anchors.left: menuButton.right
            text: position > 0.5 ? qsTr("remote") : qsTr("local")
            Material.accent: Material.Blue

        }



        // Title
        //        Label {
        //            text: "Contact List"
        //            font.pixelSize: 13
        //            anchors.centerIn: parent
        //            elide: Label.ElideRight
        //        }

        SearchBar{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
        }

    }

    ListModel {
        id: listModelJson
    }

    ListModel {
        id: listModelLocal
    }


    ScrollView {
        anchors.fill: parent
        ListView {
            id: listView
            property var elements: []
            model: switcher.position > 0.5 ? listModelJson : listModelLocal
            width: parent.width

            section.property: "firstname"
            section.criteria: ViewSection.FirstCharacter
            section.delegate: SectionDelegate {
                width: listView.width
            }

            delegate: Contact {
                width: parent.width
            }


        }
    }

    ContactDialog{
        id: contactDialog
        anchors.centerIn: parent
    }

    EditDialog{
        id: editDialog
        anchors.centerIn: parent
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
        anchors.margins: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            contactDialog.createContact()
        }
    }
}
