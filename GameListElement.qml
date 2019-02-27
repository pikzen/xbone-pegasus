import QtQuick 2.5
import QtQuick.Layouts 1.10
import QtGraphicalEffects 1.0
import "qrc:/qmlutils" as PegasusUtils

Item {
    width: 250
    height: 250
    readonly property bool selected: ListView.isCurrentItem
    Rectangle {
        id: gameListElementBackground
        anchors.fill: parent
        color: "#dbedf7"
    }
    RectangularGlow {
        anchors.fill: gameListElementBackground
        glowRadius: 6
        spread: 0.1
        color: "black"
    }
    Rectangle {
        anchors.fill: parent
        color: "#dbedf7"
    }

    Image {
        anchors.fill: parent
        id: gameListCover
        source: assets.tile || assets.boxFront || assets.poster || assets.screenshots[0] || assets.defaultTile || "./assets/default-tile.jpg"
        fillMode: (assets.tile) ? Image.Stretch : Image.PreserveAspectCrop
        onStatusChanged: if (gameListCover.status === Image.Ready) gameListCoverOpacityAnimator.restart()
        OpacityAnimator {
            id: gameListCoverOpacityAnimator
            target: gameListCover
            from: 0
            to: 1
            duration: 200
            running: false
        }
    }
    Image {
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.bottom: parent.verticalCenter
        id: gameListCoverLogo
        source: assets.logo
        fillMode: Image.PreserveAspectFit
        opacity: (assets.tile || assets.boxFront) ? 0.0 : 1.0
    }
    Rectangle {
        anchors.fill: parent
        color: selected ? "#00000000" : "#80000000"
    }
}
