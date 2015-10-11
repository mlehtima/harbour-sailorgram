import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../models"
import "../items/messageitem/media"

ContextMenu
{
    signal downloadRequested()
    signal cancelRequested()

    property Context context
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
                //FIXME: context.telegram.deleteMessages([telegramMessage.id]);
            });
        }
    }

    MenuItem
    {
        text: qsTr("Download")
        visible: telegramMessage.isMedia && !telegramMessage.media.isEmpty && loaderItem //FIXME: && !messageMediaItem.fileHandler.downloaded;

        onClicked: {
            messageitem.remorseAction(qsTr("Downloading media"), function() {
                downloadRequested();
            });
        }
    }

    MenuItem
    {
        text: qsTr("Cancel")
        visible: telegramMessage.isOut && loaderItem && loaderItem.transferInProgress
        onClicked: cancelRequested()
    }
}
