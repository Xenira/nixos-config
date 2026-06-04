pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    readonly property list<Noti> notis: []
    readonly property list<Noti> popups: notis.filter(n => n.popup)

    NotificationServer {
        id: server

        keepOnReload: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        imageSupported: true

        onNotification: noti => {
            noti.tracked = true;
            root.notis.push(notiComp.createObject(root, {
                popup: true,
                notification: noti
            }));
        }
    }

    component Noti: QtObject {
        id: noti

        property bool popup
        readonly property date time: new Date()

        required property Notification notification
        readonly property string summary: notification.summary
        readonly property string body: notification.body
        readonly property string app_icon: notification.appIcon
        readonly property bool has_app_icon: notification.appIcon.length > 0
        readonly property string app_name: notification.appName
        readonly property string image: notification.image
        readonly property bool has_image: notification.image.length > 0
        readonly property var urgency: notification.urgency
        readonly property list<NotificationAction> actions: notification.actions

        readonly property Timer timer: Timer {
            running: true
            interval: Math.max(noti.notification.expireTimeout > 0 ? noti.notification.expireTimeout : 0, 5000)
            onTriggered: {
                noti.notification.expire();
                noti.popup = false;
            }
        }

        readonly property Connections conn: Connections {
            target: noti.notification.Retainable

            function onDropped(): void {
                root.notis.splice(root.notis.indexOf(noti), 1);
            }

            function onAboutToDestroy(): void {
                noti.destroy();
            }
        }

        function dismiss(): void {
            noti.notification.dismiss();
            noti.popup = false;
        }
    }

    Component {
        id: notiComp

        Noti {}
    }
}
