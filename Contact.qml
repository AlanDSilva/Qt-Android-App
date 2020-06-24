import QtQuick 2.4
import QtQuick.Controls 2.4
import 'request.js' as Request
import 'database.js' as DB
import 'sync.js' as Sync

import MyLib 1.0


ContactForm {

    onClicked: {
        this.state === "clicked" ? this.state = "" : this.state = "clicked"
        swipe.position = 0
        }

    swipe.right: RightButtonsForm{
        width: parent.width / 3
        anchors.right: parent.right

        editButton.onClicked: {
            editDialog.editContact(firstname, lastname, mobile, email)
            editDialog.current = id;
        }
        dialButton.onClicked: dial.opendial(mobile)
    }

    swipe.left: LeftButtonsForm {
        width: parent.width / 3
        anchors.left: parent.left

//        syncButton.onClicked: Sync.syncOneToRemote(id, remote_id, firstname, lastname, mobile, email)
        deleteButton.onClicked: {
            switcher.position > 0.5 ? Request.deleteContact(id) :  DB.dbDelete(id)
        }
    }

}
