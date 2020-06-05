import QtQuick 2.4
import QtQuick.Controls 2.4
import "sync.js" as Sync

ListView {
    focus: true
    currentIndex: -1
    anchors.fill: parent

    delegate: ItemDelegate {
        width: parent.width
        text: model.text
        highlighted: ListView.isCurrentItem
        onClicked: {
            drawer.close()
            model.triggered()
        }
    }

    model: ListModel {
        ListElement {
            text: qsTr("Sync to Local Database")
            triggered: function(){
                console.log("Will save to database");
                Sync.syncToLocal();
            }
        }
        ListElement {
            text: qsTr("Sync to Remote Database")
            triggered: function(){
                console.log("Will sync to remote");
                Sync.syncToRemote();
            }
        }
    }

    ScrollIndicator.vertical: ScrollIndicator { }
}
