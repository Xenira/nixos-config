pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
    id: root
    property string status

    Process {
        id: statusProc
        command: ["iserv", "--non-interactive", "status", "-o", "short"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.status = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: statusProc.running = true
    }
}
