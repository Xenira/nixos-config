pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import QtQuick.Layouts
import "root:/config"

RowLayout {
    id: root

    required property ListModel buttons
    property bool roundTop: false
    property bool roundBottom: true

    spacing: Appearance.spacing.smaller

    Repeater {
        model: root.buttons

        delegate: Button {
            required property int index
            required property ListElement modelData
            readonly property bool isFirst: index === 0
            readonly property bool isLast: index === (root.count - 1)

            button: modelData
            roundTopLeft: root.roundTop && isFirst
            roundTopRight: root.roundTop && isLast
            roundBottomLeft: root.roundBottom && isFirst
            roundBottomRight: root.roundBottom && isLast

            implicitWidth: root.width / root.buttons.count
        }
    }
}
