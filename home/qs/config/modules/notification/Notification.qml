pragma ComponentBehavior: Bound

import "root:/config"
import "root:/services"
import "root:/widgets"
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    required property Noti.Noti notification
    readonly property int nonAnimHeight: summary.implicitHeight + appName.height + body.height + actions.height + actions.anchors.topMargin + content.anchors.margins * 2
    // readonly property int nonAnimHeight: content.height

    // color: root.notification.urgency === NotificationUrgency.Critical ? Colours.palette.m3secondaryContainer : Colours.palette.m3surfaceContainer
    // radius: Appearance.rounding
    color: "transparent"
    implicitWidth: NotiConfig.sizes.width
    implicitHeight: content.implicitHeight

    RetainableLock {
        object: root.notification.notification
        locked: true
    }

    // MouseArea {
    //     property int startY
    //
    //     anchors.fill: parent
    //     hoverEnabled: true
    //     cursorShape: pressed ? Qt.ClosedHandCursor : undefined
    //     acceptedButtons: Qt.LeftButton
    //     preventStealing: true
    //
    //     onPressed: {
    //         startY = event.y;
    //     }
    // }

    Item {
        id: content

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        implicitHeight: root.nonAnimHeight

        Behavior on implicitHeight {
            Anim {}
        }

        Loader {
            id: image

            active: root.notification.has_image
            asynchronous: true

            anchors.left: parent.left
            anchors.top: parent.top
            width: NotiConfig.sizes.image
            height: NotiConfig.sizes.image
            visible: root.notification.has_image || root.notification.has_app_icon

            sourceComponent: ClippingRectangle {
                radius: Appearance.rounding
                implicitWidth: NotiConfig.sizes.image
                implicitHeight: NotiConfig.sizes.image

                Image {
                    anchors.fill: parent
                    source: Qt.resolvedUrl(root.notification.image)
                    fillMode: Image.PreserveAspectCrop
                    cache: false
                    asynchronous: true
                }
            }
        }

        Loader {
            id: appIcon

            active: root.notification.has_app_icon || !root.notification.has_image
            asynchronous: true

            anchors.horizontalCenter: root.notification.has_image ? undefined : image.horizontalCenter
            anchors.verticalCenter: root.notification.has_image ? undefined : image.verticalCenter
            anchors.right: root.notification.has_image ? image.right : undefined
            anchors.bottom: root.notification.has_image ? image.bottom : undefined

            sourceComponent: StyledRect {
                radius: Appearance.rounding
                color: root.notification.urgency === NotificationUrgency.Critical ? Colours.palette.m3error : root.notification.urgency === NotificationUrgency.Low ? Colours.palette.m3surfaceContainerHighest : Colours.palette.m3tertiaryContainer
                implicitWidth: root.notification.has_image ? NotiConfig.sizes.badge : NotiConfig.sizes.image
                implicitHeight: root.notification.has_image ? NotiConfig.sizes.badge : NotiConfig.sizes.image

                Loader {
                    id: icon

                    active: root.notification.has_app_icon
                    asynchronous: true

                    anchors.centerIn: parent
                    visible: !root.notification.app_icon.endsWith("symbolic")

                    width: Math.round(parent.width * 0.6)
                    height: Math.round(parent.width * 0.6)

                    sourceComponent: IconImage {
                        implicitSize: Math.round(parent.width * 0.6)
                        source: Quickshell.iconPath(root.notification.app_icon)
                        asynchronous: true
                    }
                }

                Loader {
                    active: !root.notification.has_app_icon
                    asynchronous: true
                    anchors.centerIn: parent

                    sourceComponent: MaterialIcon {
                        text: {
                            const summary = root.notification.summary.toLowerCase();
                            if (summary.includes("reboot"))
                                return "restart_alt";
                            if (summary.includes("recording"))
                                return "screen_record";
                            if (summary.includes("battery"))
                                return "power";
                            if (summary.includes("screenshot"))
                                return "screenshot_monitor";
                            if (summary.includes("welcome"))
                                return "waving_hand";
                            if (summary.includes("time") || summary.includes("a break"))
                                return "schedule";
                            if (summary.includes("installed"))
                                return "download";
                            if (summary.includes("update"))
                                return "update";
                            if (summary.startsWith("file"))
                                return "folder_copy";
                            if (root.notification.urgency === NotificationUrgency.Critical)
                                return "release_alert";
                            return "chat";
                        }

                        color: root.notification.urgency === NotificationUrgency.Critical ? Colours.palette.m3onError : root.notification.urgency === NotificationUrgency.Low ? Colours.palette.m3onSurface : Colours.palette.m3onTertiaryContainer
                        font.pointSize: Appearance.font.size.large
                    }
                }
            }
        }

        StyledText {
            id: appName

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.leftMargin: Appearance.spacing.smaller
            anchors.rightMargin: Appearance.spacing.smaller

            animate: true
            text: appNameMetrics.elidedText
            maximumLineCount: 1
            color: "black"
            font.pointSize: Appearance.font.size.small

            Behavior on opacity {
                Anim {}
            }
        }

        TextMetrics {
            id: appNameMetrics

            text: root.notification.app_name
            font.family: appName.font.family
            font.pointSize: summary.font.pointSize
            elide: Text.ElideRight
            elideWidth: content.width - summary.x - Appearance.spacing.small * 3
            // elideWidth: expandBtn.x - time.width - timeSep.width - summary.x - Appearance.spacing.small * 3
        }

        StyledText {
            id: summary

            anchors.top: parent.top
            anchors.left: image.right
            anchors.leftMargin: Appearance.spacing.smaller

            animate: true
            text: summaryMetrics.elidedText
            maximumLineCount: 1
            height: implicitHeight
            color: "black"

            Behavior on height {
                Anim {}
            }
        }

        TextMetrics {
            id: summaryMetrics

            text: root.notification.summary
            font.family: summary.font.family
            font.pointSize: summary.font.pointSize
            elide: Text.ElideRight
            elideWidth: content.width - summary.x - Appearance.spacing.small * 3
            // elideWidth: expandBtn.x - time.width - timeSep.width - summary.x - Appearance.spacing.small * 3
        }

        // Text {
        //     id: timeSep
        //
        //     anchors.top: parent.top
        //     anchors.left: summary.right
        //     anchors.leftMargin: Appearance.spacing.small
        //
        //     text: "•"
        //     color: Colours.palette.m3onSurfaceVariant
        //     font.pointSize: Appearance.font.size.small
        //
        //     states: State {
        //         name: "expanded"
        //         when: root.expanded
        //
        //         AnchorChanges {
        //             target: timeSep
        //             anchors.left: appName.right
        //         }
        //     }
        //
        //     transitions: Transition {
        //         AnchorAnimation {
        //             duration: Appearance.anim.durations.normal
        //             easing.type: Easing.BezierSpline
        //             easing.bezierCurve: Appearance.anim.curves.standard
        //         }
        //     }
        // }

        // Text {
        //     id: time
        //
        //     anchors.top: parent.top
        //     anchors.left: timeSep.right
        //     anchors.leftMargin: Appearance.spacing.small
        //
        //     // animate: true
        //     horizontalAlignment: Text.AlignLeft
        //     text: root.notification.timeStr
        //     color: Colours.palette.m3onSurfaceVariant
        //     font.pointSize: Appearance.font.size.small
        // }

        // Text {
        //     id: bodyPreview
        //
        //     anchors.left: summary.left
        //     anchors.right: content.right
        //     // anchors.leftMargin: Appearance.spacing.smaller
        //     anchors.top: summary.bottom
        //     anchors.rightMargin: Appearance.spacing.small
        //
        //     // animate: true
        //     textFormat: Text.MarkdownText
        //     text: bodyPreviewMetrics.elidedText
        //     color: Colours.palette.m3onSurfaceVariant
        //     font.pointSize: Appearance.font.size.small
        //
        //     // opacity: root.expanded ? 0 : 1
        //
        //     Behavior on opacity {
        //         Anim {}
        //     }
        // }
        //
        // TextMetrics {
        //     id: bodyPreviewMetrics
        //
        //     text: root.notification.body
        //     font.family: bodyPreview.font.family
        //     font.pointSize: bodyPreview.font.pointSize
        //     elide: Text.ElideRight
        //     elideWidth: bodyPreview.width
        // }

        StyledText {
            id: body

            anchors.left: summary.left
            anchors.right: parent.right
            anchors.top: summary.bottom
            anchors.margins: Appearance.spacing.small

            // animate: true
            textFormat: Text.MarkdownText
            text: root.notification.body
            color: "black"
            font.pointSize: Appearance.font.size.small
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere

            Behavior on opacity {
                Anim {}
            }

            onLinkActivated: link => {
                Qt.openUrlExternally(link);
                root.notification.dismiss();
            }
        }

        // ListModel {
        //     id: actionsModel
        //
        //     Component.onCompleted: {
        //         for (const action of root.notification.actions) {
        //             actionsModel.append({
        //                 text: action.text || action.identifier,
        //                 action: action
        //             });
        //         }
        //     }
        // }
        //
        // ButtonGroup {
        //     id: actions
        //     buttons: actionsModel
        //
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     anchors.top: body.bottom
        //     anchors.topMargin: Appearance.spacing.small
        //
        //     implicitWidth: parent.width
        // }
        RowLayout {
            id: actions

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: body.bottom
            anchors.topMargin: Appearance.spacing.small

            spacing: Appearance.spacing.smaller

            Behavior on opacity {
                Anim {}
            }

            Repeater {
                model: root.notification.actions

                delegate: Rectangle {
                    id: action

                    required property NotificationAction modelData

                    radius: Appearance.rounding
                    color: Colours.palette.m3surfaceContainerHigh

                    Layout.preferredWidth: actionText.width + Appearance.padding.normal * 2
                    Layout.preferredHeight: actionText.height + Appearance.padding.small * 2
                    implicitWidth: actionText.width + Appearance.padding.normal * 2
                    implicitHeight: actionText.height + Appearance.padding.small * 2

                    StateLayer {
                        radius: Appearance.rounding

                        function onClicked(): void {
                            action.modelData.invoke();
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

                        text: action.modelData.text || action.modelData.identifier
                        font.family: actionText.font.family
                        font.pointSize: actionText.font.pointSize
                        elide: Text.ElideRight
                        elideWidth: {
                            const numActions = root.notification.actions.length;
                            return (content.width - actions.spacing * (numActions - 1)) / numActions - Appearance.padding.normal * 2;
                        }
                    }
                }
            }
        }
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.standard
    }
}
