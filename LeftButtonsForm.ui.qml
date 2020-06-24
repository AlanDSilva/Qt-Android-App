import QtQuick 2.4
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Row {
    property alias deleteButton: deleteButton
    //    property alias syncButton: syncButton

    //    Button {
    //        id: syncButton

    //        // <div>Icons made by <a href="https://www.flaticon.com/authors/srip" title="srip">srip</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
    //        // <div>Icons made by <a href="https://www.flaticon.com/authors/srip" title="srip">srip</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
    //        icon.source: switcher.position > 0.5 ? "images/download.svg" : "images/upload.svg"
    //        Material.background: Material.LightBlue
    //    }
    Button {
        id: deleteButton

        // <div>Icons made by <a href="https://www.flaticon.com/authors/bqlqn" title="bqlqn">bqlqn</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
        icon.source: "images/delete.svg"
        Material.background: Material.Red
    }
}
