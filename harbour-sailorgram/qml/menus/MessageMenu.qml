import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../models"
import "../items/message/messageitem/media"

ContextMenu
{
    signal downloadRequested()
    signal deleteRequested()
    signal cancelRequested()

    property Message telegramMessage
    property MessageMediaItem loaderItem

    MenuItem
    {
        text: qsTr("Copy")
        visible: !telegramMessage.isMedia || telegramMessage.media.isEmpty

        onClicked: {
            Clipboard.text = telegramMessage.message;
            popupmessage.show(qsTr("Message copied to clipboard"));
        }
    }

    MenuItem
    {
        text: qsTr("Delete")

        onClicked: {
            messageitem.remorseAction(qsTr("Deleting Message"), function() {
                deleteRequested();
            });
        }
    }

    MenuItem
    {
        text: qsTr("Download")
        visible: telegramMessage.isMedia && !telegramMessage.media.isEmpty && (loaderItem && !loaderItem.telegramFile.downloaded)

        onClicked: {
            messageitem.remorseAction(qsTr("Downloading media"), function() {
                downloadRequested();
            });
        }
    }

    MenuItem
    {
        text: qsTr("Cancel")
        visible: telegramMessage.isOut && (loaderItem && loaderItem.telegramFile.downloading)
        onClicked: cancelRequested()
    }
}
