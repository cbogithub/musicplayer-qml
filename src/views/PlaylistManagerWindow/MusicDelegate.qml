import QtQuick 2.4
import DMusic 1.0
import "../DMusicWidgets"

Rectangle {
    id: mediaItem

    property var mouseArea: mouseArea

    width: parent.width
    height: 24
    color: "transparent"

    signal menuShowed(int index)

    Row {

        anchors.fill: parent
        spacing: 10

        Rectangle{
            id: tipRect
            width: 20
            height: 24

            color: "transparent"

            Text {
                id: indexTip
                anchors.centerIn: parent
                text: index + 1
                visible: !waveBar.active
            }

            DWaveBar {
                id: waveBar
                anchors.centerIn: parent
                itemHeight: 12
                itemWidth: 3
                active: false
            }
        }

        Row {
            height: 24
            spacing: 38

            Text {
                id: titleTetx
                width: 250
                height: 24
                color: "#3a3a3a"
                font.pixelSize: 12
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                text: mediaItem.ListView.view.model[index].title
            }

            Text {
                id: artistText
                width: 156
                height: 24
                color: "#8a8a8a"
                font.pixelSize: 12
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                text: mediaItem.ListView.view.model[index].artist
            }

            Text {
                id: durationText
                width: 50
                height: 24
                color: "#8a8a8a"
                font.pixelSize: 12
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                text: mediaItem.ListView.view.model[index].duration
            }
        }
    }

    states: [
        State {
            name: "Active"
            PropertyChanges { target: titleTetx; color: "#2ca7f8"}
            PropertyChanges { target: waveBar; active: true ;}
        },
        State {
            name: "Current"
            when: mediaItem.ListView.isCurrentItem
            PropertyChanges { target: titleTetx; color: "#2ca7f8";}
        },
        State {
            name: "!Current"
            when: !mediaItem.ListView.isCurrentItem
            PropertyChanges { target: waveBar; active: false ;}
        }
    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onEntered: {
            if (mediaItem.ListView.view.currentIndex != index){
                // playButton.visible = true;
                mediaItem.color = "lightgray"
            }else{
                // playButton.visible = ! waveBar.visible;
                mediaItem.color = "transparent"
            }
        }
        onExited: {
            // playButton.visible = false
            mediaItem.color = "transparent"
        }
        onClicked: {
            if (mouse.button == Qt.LeftButton){
                mediaItem.ListView.view.currentIndex = index;
                var url = mediaItem.ListView.view.model[index].url
                mediaItem.ListView.view.playMusicByUrl(url);
                waveBar.active = true
            }
            else if (mouse.button == Qt.RightButton){
                mediaItem.menuShowed(index);
            }
        }
    }
}