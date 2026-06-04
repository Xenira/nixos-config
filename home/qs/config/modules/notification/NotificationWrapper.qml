import QtQuick

Item {
    id: root

    visible: height > 0
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    NotificationList {
        id: content
    }
}
