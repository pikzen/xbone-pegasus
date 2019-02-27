import QtQuick 2.5
import QtQuick.Layouts 1.10
import QtGraphicalEffects 1.0
import "qrc:/qmlutils" as PegasusUtils

FocusScope {
    Keys.onTabPressed: {
        api.collections.incrementIndex();
        api.currentCollection.games.index = 0
    }
    Keys.onRightPressed: {
        api.currentCollection.games.incrementIndex()
    }
    Keys.onLeftPressed: api.currentCollection.games.decrementIndex()
    Keys.onReturnPressed: api.currentGame.launch()
    Keys.onPressed: {
        if (api.keys.isAccept(event)) { api.currentGame.launch() }
        if (api.keys.isNextPage(event)) {
            api.collections.incrementIndex();
            api.currentCollection.games.index = 0
        }
        if (api.keys.isPrevPage(event)) {
            api.collections.decrementIndex();
            api.currentCollection.games.index = 0
        }
    }

    property variant defaultBackgrounds: [
        "assets/bg1.png",
        "assets/bg2.jpg"
    ]
    function pickOne(from) {
        if (!from) return null
        if (from.length === 0) return null
        var picked = from[Math.floor(Math.random() * from.length)]
        return picked
    }

    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Image {
            property var currentGame: api.currentCollection.games.current
            property var screenshots: currentGame.assets.screenshots
            id: pageBackgroundImage
            source: pickOne(screenshots) || pickOne(defaultBackgrounds)
            fillMode: Image.PreserveAspectCrop
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            asynchronous: true
            opacity: 0
            onStatusChanged: if (pageBackgroundImage.status === Image.Ready) pageBackgroundOnEnter.restart()
            OpacityAnimator on opacity {
                id: pageBackgroundOnEnter
                from: 0
                to: 1
                duration: 1000
                running: false
            }
            OpacityAnimator on opacity {
                id: pageBackgroundOnExit
                from: 1
                to: 0
                duration: 250
                running: false
            }
        }
        Rectangle {
            anchors.fill: pageBackgroundImage
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#DD000000" }
                GradientStop { position: 0.25; color: "#88000000" }
                GradientStop { position: 0.40; color: "#40CCCCCC" }
                GradientStop { position: 0.75; color: "#40CCCCCC" }
                GradientStop { position: 1.0; color: "#DD000000" }
            }
        }

        Item {
            id: platformSwitcher
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 60

            property var collectionList: api.collections.model

            ListView {
                id: platformSwitcherElements
                anchors.top: parent.top
                anchors.topMargin: 36
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                highlightMoveDuration: 250

                transformOrigin: Item.Center
                snapMode: ListView.SnapPosition
                Layout.alignment: Qt.AlignCenter
                Layout.minimumWidth: 60 * 5 + 60
                orientation: ListView.Horizontal
                model: api.collections.model
                currentIndex: api.collections.index
                delegate: CollectionListElement { }

                spacing: 150
                preferredHighlightBegin: (width / 2)
                preferredHighlightEnd: (width / 2)
                highlightRangeMode: ListView.StrictlyEnforceRange
            }

            Rectangle {
                color: "purple"
                anchors.horizontalCenter: platformSwitcherElements.horizontalCenter
                anchors.bottom: platformSwitcherElements.bottom
                height: 4
                width: 80
            }
        }

        Text {
            property var currentGame: api.currentCollection.games.current
            id: currentGameText
            text: currentGame.title
            anchors.top: platformSwitcher.bottom
            anchors.left: parent.left
            anchors.leftMargin: 64
            anchors.topMargin: 64
            font.family: "Segoe UI"
            font.pointSize: 30
            font.weight: Font.Bold
            color: "white"
            style: Text.Raised
            fontSizeMode: Text.HorizontalFit
        }
        Text {
            property var currentGame: api.currentCollection.games.current
            id: currentGameDeveloper
            text: currentGame.developer
            anchors.top: currentGameText.bottom
            anchors.left: parent.left
            anchors.leftMargin: 64
            font.family: "Segoe UI"
            font.pointSize: 12
            color: "white"
            style: Text.Raised
            fontSizeMode: Text.HorizontalFit
        }

    }
    ListView {
        id: platformCollection
        height: 200
        anchors.bottomMargin: 96
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: -24
        orientation: ListView.Horizontal
        spacing: 24
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: 72
        preferredHighlightEnd: width - 72
        highlightMoveDuration: 100
        transformOrigin: Item.Center

        currentIndex: api.currentCollection.games.index

        model: api.currentCollection.games.model
        delegate: GameListElement { }
    }
}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
