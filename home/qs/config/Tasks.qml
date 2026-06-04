import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Hyprland
import QtQuick

FloatingWindow {
    id: root
    title: "Tasks"
    color: "transparent"
    implicitHeight: taskList.contentHeight + 20
    visible: TaskStack.tasks.length > 0
    // HyperlandWindow.visibleMask: Region {
    //     x: 0
    //     y: 0
    //     width: container.targetWidth
    //     height: container.targetHeight
    // }

    ListView {
        id: taskList
        anchors.fill: parent
        model: TaskStack.tasks
        delegate: Item {
            width: parent.width
            height: container.height

            SciFiRect {
                id: container
                anchors.fill: parent
                backgroundColor: Qt.rgba(0.2, 0.2, 0.2, 0.75)
                targetWidth: parent.width
                targetHeight: titleText.height + descriptionText.height + 20

                Text {
                    id: titleText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    text: modelData.title
                    color: "white"
                    font.pixelSize: 16
                }
                Text {
                    id: descriptionText
                    anchors.margins: 10
                    anchors.top: titleText.bottom
                    anchors.left: parent.left
                    text: modelData.description
                    textFormat: Text.MarkdownText
                    color: "white"
                    font.pixelSize: 12
                }
            }
        }
    }
}
