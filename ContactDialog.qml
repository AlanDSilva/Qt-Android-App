import QtQuick 2.4
import QtQuick.Controls 2.5
import 'request.js' as Request
import 'database.js' as DB


Dialog{
    title: "Add Contact"
    standardButtons: Dialog.Ok | Dialog.Cancel

        ContactDialogForm {
            id: form
        }

    onAccepted: doInsert()

    onRejected: console.log("Cancel clicked")


    function doInsert(){
        if(switcher.position > 0.5)
            Request.addContact()
        else
            DB.dbInsert()
    }



    function createContact(){
        // Clears all form fields
        form.firstName.clear()
        form.lastName.clear()
        form.mobile.clear()
        form.email.clear()

        //opens
        this.open()
    }

}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
