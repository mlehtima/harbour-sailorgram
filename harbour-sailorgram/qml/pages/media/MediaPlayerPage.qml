import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../components"
import "../../components/mediaplayer"

MediaPage
{
    property string mediaCaption
    property File mediaThumbnail

    id: mediaplayerpage
    allowedOrientations: defaultAllowedOrientations

    RemorsePopup { id: remorsepopup }

    PopupMessage
    {
        id: popupmessage
        anchors { left: parent.left; top: parent.top; right: parent.right }
    }

    MediaPlayer
    {
        id: mediaplayer
        anchors.fill: parent
        videoTitle: mediaCaption
        videoSource: telegramFile.filePath

        videoThumbnail: {
            if(!videoThumbnail)
                return "";

            if(!videoThumbnail.downloaded)
                videoThumbnail.download();

            return videoThumbnail.filePath;
        }
    }

    ProgressCircle
    {
        anchors.centerIn: parent
        width: Theme.iconSizeLarge
        height: Theme.iconSizeLarge
        visible: telegramFile.downloading
        //FIXME: progressValue: fileHandler.progressPercent / 100
    }
}
