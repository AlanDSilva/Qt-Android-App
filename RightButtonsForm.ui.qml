import QtQuick 2.4
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Row {
    property alias dialButton: dialButton
    property alias editButton: editButton

    Button {
        id: editButton
        icon.source: "images/edit.svg" // Icons made by <a href="https://www.flaticon.com/authors/becris" title="Becris">Becris</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
        Material.background: Material.Yellow
    }

    Button {
        id: dialButton
        icon.source: "images/phone.svg" // Icons made by <a href="https://www.flaticon.com/authors/bqlqn" title="bqlqn">bqlqn</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
        Material.background: Material.Green
    }
}
