import QtQuick 2.5
import QtQuick.Layouts 1.10

Component {
    id: pageBackground
    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Rectangle {
            id: whoCares
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: "red"
            visible: false
        }

        Image {
            id: pageBackgroundImage
            source: "G:\Emulation\Roms\Gamecube\assets\TwilightPrincess\screenshots\0.jpg"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}
