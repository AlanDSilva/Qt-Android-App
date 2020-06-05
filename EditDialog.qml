import QtQuick 2.4
import QtQuick.Controls 2.5
import 'request.js' as Request
import 'database.js' as DB


Dialog{

    property var current

    title: "Edit Contact"
    standardButtons: Dialog.Ok | Dialog.Cancel

        EditDialogForm {
            id: editform
        }

    onAccepted: doEdit()

    onRejected: console.log("Cancel clicked")


    function doEdit() {
        if(switcher.position > 0.5)
            Request.editContact(current)
        else
            DB.dbUpdate(current)
    }


    function editContact(fn, ln, mb, email){
        // Clears all form fields
        editform.firstName.text = fn
        editform.lastName.text = ln
        editform.mobile.text = mb
        editform.email.text = email

        //opens
        this.open()
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
