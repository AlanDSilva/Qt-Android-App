import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

GridLayout {
    width: 200
    height: 200
    property alias email: email
    property alias mobile: mobile
    property alias lastName: lastName
    property alias firstName: firstName
    columns: 2
    rows: 4

    Label {
        id: label
        text: qsTr("First Name")
    }

    TextField {
        id: firstName
        text: qsTr("Text Field")
        font.family: "Tahoma"
    }

    Label {
        id: label1
        text: qsTr("Last Name")
    }

    TextField {
        id: lastName
        text: qsTr("Text Field")
    }

    Label {
        id: label2
        text: qsTr("Mobile")
    }

    TextField {
        id: mobile
        text: qsTr("Text Field")
    }

    Label {
        id: label3
        text: qsTr("Address")
    }

    TextField {
        id: email
        text: qsTr("Text Field")
    }
}
