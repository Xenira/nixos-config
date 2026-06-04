import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

ClippingRectangle {
    id: root
    property color backgroundColor: Qt.rgba(255, 255, 255, 0.5)
    color: Qt.rgba(backgroundColor.r, backgroundColor.g, backgroundColor.b, 0.5)
    property variant animationEasing: Easing.InOutQuad
    property real targetWidth
    property real targetHeight
    property string borderImageSource: "../assets/border.png"
    width: targetWidth
    height: targetHeight

    BorderImage {
        id: background
        source: root.borderImageSource
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

    MultiEffect {
        source: background
        anchors.fill: background
        colorizationColor: root.backgroundColor
        colorization: 0.75
        saturation: 1.6
        contrast: 0.2
    }

    function heightAnimDuration() {
        return Math.max(0, Math.min(1000, Math.abs(root.height - root.targetHeight) * 3));
    }

    function widthAnimDuration(pause = false) {
        return Math.max(0, Math.min(1000, Math.abs(root.width - root.targetWidth) * 0.6 - (pause ? 200 : 0)));
    }

    Behavior on height {
        id: heightBehavior
        // animation: sizeAnim
        SequentialAnimation {
            ScriptAction {
                script: {
                    pauseAnim.duration = root.widthAnimDuration(true);
                    heightAnim.duration = root.heightAnimDuration();
                }
            }
            PauseAnimation {
                id: pauseAnim
            }
            SmoothedAnimation {
                id: heightAnim
                easing.type: root.animationEasing
            }
        }
    }
    Behavior on width {
        id: widthBehavior
        SequentialAnimation {
            ScriptAction {
                script: widthAnim.duration = root.widthAnimDuration()
            }
            SmoothedAnimation {
                id: widthAnim
                // target: clockAndNotifications
                // property: "width"
                // duration: widthBehavior.widthDuration
                easing.type: root.animationEasing
            }
        }
    }
}
