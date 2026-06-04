import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "root:/widgets"
import "root:/config"
import "root:/modules/notification"

Scope {
    id: root
    property color panelColor: Qt.rgba(240, 240, 240, 0.75)
    property int height: 22

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel
            required property var modelData
            screen: modelData
            surfaceFormat.opaque: false
            color: "transparent"
            exclusionMode: Hyprland.monitorFor(modelData).activeWorkspace.id == 1 ? ExclusionMode.Normal : ExclusionMode.Ignore
            // implicitHeight: clockAndNotifications.height + 10
            mask: Region {
                item: notifications
            }

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            BorderImage {
                id: background
                source: "./assets/border.png"
                anchors.fill: parent
                border {
                    left: 10
                    top: 10
                    right: 10
                    bottom: 10
                }
                smooth: false
                verticalTileMode: BorderImage.Repeat
                horizontalTileMode: BorderImage.Repeat
            }

            // implicitHeight: root.height
            SciFiRect {
                id: clockAndNotifications
                anchors.horizontalCenter: parent.horizontalCenter
                targetWidth: Math.max(clock.width + battery.width * 1.5, notifications.width) + 40
                targetHeight: clock.height + notifications.height + 10
                animationEasing: Easing.InQuad
                backgroundColor: "lightblue"
                borderImageSource: "../assets/border_lr.png"

                Clock {
                    id: clock
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.margins: 5
                }
                Battery {
                    id: battery
                    anchors.left: clock.right
                    anchors.margins: 5
                    anchors.verticalCenter: clock.verticalCenter
                }
                NotificationWrapper {
                    id: notifications
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: clock.bottom
                    anchors.margins: 5
                }
            }

            SciFiRect {
                anchors.left: parent.left
                anchors.top: parent.top
                targetWidth: workspaceText.width + 20
                targetHeight: root.height
                backgroundColor: "lightblue"
                borderImageSource: "../assets/border_none.png"

                Text {
                    id: workspaceText
                    anchors.centerIn: parent
                    // anchors.centerIn: p
                    property var currentMonitor: Hyprland.monitorFor(modelData)
                    text: currentMonitor.activeWorkspace.id
                }
            }

            SciFiRect {
                anchors.right: parent.right
                anchors.top: parent.top
                visible: workTimer.width > 0
                targetWidth: workTimer.width + 20
                targetHeight: root.height
                backgroundColor: "lightblue"
                borderImageSource: "../assets/border_lr.png"

                WorkTimerWidget {
                    id: workTimer
                    // }
                    anchors.centerIn: parent
                }
            }
        }
    }

    component Anim: NumberAnimation {
        target: root
        property: root.animateProp
        duration: root.animateDuration / 2
        easing.type: Easing.BezierSpline
    }
}
