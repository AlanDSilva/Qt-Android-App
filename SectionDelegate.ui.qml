import QtQuick 2.4
import QtQuick.Controls 2.12

ToolBar {
    id: background
    height: 20

    Label {
        id: label
        text: section
        anchors.fill: parent
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
}
