pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
    id: root
    property var tasks: []

    Process {
        id: listProc
        command: ["task_stack", "--json", "list"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.tasks = JSON.parse(this.text);
                } catch (e) {
                    console.error("Failed to parse task stack JSON:", e, "Raw output:", this.text);
                    root.tasks = [];
                }
            }
        }
    }

    Process {
        id: removeProc
        running: false
    }

    function removeTask(taskId) {
        removeProc.call(["task_stack", "remove", taskId]);
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: listProc.running = true
    }
}
