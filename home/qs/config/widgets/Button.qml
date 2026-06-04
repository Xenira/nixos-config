import Quickshell
import QtQuick
import "root:/config"
import "root:/services"

Rectangle {
    id: root

    required property ListElement button
    property bool roundTopLeft: false
    property bool roundTopRight: false
    property bool roundBottomLeft: true
    property bool roundBottomRight: true
    property color backgroundColor: Colours.palette.m3surfaceContainerHigh

    topLeftRadius: root.roundTopLeft ? Appearance.rounding : 0
    topRightRadius: root.roundTopRight ? Appearance.rounding : 0
    bottomLeftRadius: root.roundBottomLeft ? Appearance.rounding : 0
    bottomRightRadius: root.roundBottomRight ? Appearance.rounding : 0
    color: backgroundColor

    StateLayer {
        topLeftRadius: root.roundTopLeft ? Appearance.rounding : 0
        topRightRadius: root.roundTopRight ? Appearance.rounding : 0
        bottomLeftRadius: root.roundBottomLeft ? Appearance.rounding : 0
        bottomRightRadius: root.roundBottomRight ? Appearance.rounding : 0

        function onClicked(): void {
            root.button.action.invoke();
        }
    }

    StyledText {
        id: actionText

        anchors.centerIn: parent
        text: actionTextMetrics.elidedText
        color: Colours.palette.m3onSurfaceVariant
        font.pointSize: Appearance.font.size.small
    }

    TextMetrics {
        id: actionTextMetrics

        text: root.button.text
        font.family: actionText.font.family
        font.pointSize: actionText.font.pointSize
        elide: Text.ElideRight
        elideWidth: root.width
    }
}
