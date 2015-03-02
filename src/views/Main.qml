import QtQuick 2.0
import QtQuick.Window 2.1
import DMusic 1.0

Item {
    id: root
    objectName: "root"

    width: constants.mainWindowWidth
    height: constants.mainWindowHeight

    Constants{
        id: constants
    }

    MainWindow {
        id: mainWindow
        objectName: "MainWindow"

        anchors.fill: parent
        
        width: root.width
        height: root.heigh
        visible : true
    }

    SimpleWindow {
        id: simpleWindow
        width: root.width
        height: root.height
        anchors.fill: parent
        visible : false
    }

    MiniWindow {
        id: miniWindow
        width: constants.miniWindowWidth
        height: constants.miniWindowHeight
    }

    MainController {
        id: mainController
        rootWindow: root
        mainWindow: mainWindow
        simpleWindow: simpleWindow
        miniWindow: miniWindow
        constants: constants
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_F1) {
            mainWindow.mainWindowController.resetSkin();
            simpleWindow.simpleWindowController.resetSkin();
            miniWindow.miniWindowController.resetSkin();
        }else if (event.key == Qt.Key_F2) {
            mainWindow.mainWindowController.setSkinByImage();
            simpleWindow.simpleWindowController.setSkinByImage();
            miniWindow.miniWindowController.setSkinByImage();
        }
    }
}