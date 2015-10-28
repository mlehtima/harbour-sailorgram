import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../components"

MediaPage
{
    id: mediaphotopage
    allowedOrientations: defaultAllowedOrientations

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("Save in Gallery")

                onClicked: {
                    //FIXME: context.sailorgram.moveMediaToGallery(telegramFile);
                    popupmessage.show(qsTr("Image saved in Gallery"));
                }
            }
        }

        PopupMessage
        {
            id: popupmessage
            anchors { left: parent.left; top: parent.top; right: parent.right }
        }

        /*
        PinchArea
        {
            property int initialWidth
            property int initialHeight

            anchors.fill: parent
            pinch.target: image
            pinch.dragAxis: Pinch.XAndYAxis
            pinch.minimumScale: 1
            pinch.maximumScale: 10

            onPinchStarted: {
                initialWidth = image.sourceSize.width
                initialHeight = image.sourceSize.height
            }

            onPinchUpdated: {
                flickable.contentX += pinch.previousCenter.x - pinch.center.x;
                flickable.contentY += pinch.previousCenter.y - pinch.center.y;
            }

            onPinchFinished: flickable.returnToBounds()
        }
        */

        Image
        {
            id: image
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            cache: false
            source: telegramFile.filePath

            BusyIndicator
            {
                anchors.centerIn: parent
                size: BusyIndicatorSize.Medium
                running: telegramFile.downloading
            }
        }
    }
}
