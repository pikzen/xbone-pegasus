import QtQuick 2.5
import QtQuick.Layouts 1.10
import QtGraphicalEffects 1.0
import "qrc:/qmlutils" as PegasusUtils

Item {
    readonly property bool selected: ListView.isCurrentItem
    TextMetrics {
        id: textMetrics
        font.family: "Segoe UI"
        font.pointSize: selected ? 14 : 12

    }

    Text {
        anchors.centerIn: parent
        text: modelData.name.length < 20 ? modelData.name : modelData.shortName.toUpperCase()
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Segoe UI"
        font.pointSize: selected ? 14 : 12
        font.weight: Font.DemiBold
        color: "white"
        style: Text.Raised
    }
}
