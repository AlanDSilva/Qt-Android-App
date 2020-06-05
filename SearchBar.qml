import QtQuick 2.4
import QtQuick.Controls 2.5
import "request.js" as Request
import "database.js" as DB

SearchBarForm {

    searchtext.onTextChanged: doSearch()

    resetSearchBtn.onClicked: endSearch()


    // Decides which search function to call depending on switch
    function doSearch() {
        if(switcher.position > 0.5)
            Request.searchContact(searchtextText)
        else
            DB.dbSearch(searchtextText)
    }

    // Resets both listmodels when search is cancelled
    function endSearch() {
        searchtextText = "";
        Request.getContacts2();
        DB.dbGetAll();
    }

}
