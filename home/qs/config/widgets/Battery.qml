pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.UPower
import "root:/config"

Item {
    id: root

    property UPowerDevice device: UPower.displayDevice
    readonly property bool charging: device.state == UPowerDeviceState.Charging
    readonly property bool discharging: device.state == UPowerDeviceState.Discharging
    implicitWidth: root.visible ? infoText.width : 0
    implicitHeight: root.visible ? infoText.height : 0

    visible: (charging || discharging) && device.percentage < 0.9
    opacity: 1.25 - root.device.percentage

    StyledText {
        id: infoText
        text: root.device.percentage < 0.33 ? (root.device.percentage * 100).toFixed(0) + "%" : charging ? "⦿" : "•"
        color: root.device.percentage > 0.75 ? "green" : root.device.percentage > 0.5 ? "orange" : root.device.percentage > 0.25 ? "orangered" : "red"
    }
}
