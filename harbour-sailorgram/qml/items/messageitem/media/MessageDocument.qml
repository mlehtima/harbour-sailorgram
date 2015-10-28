import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../../models"
import "../../../js/TelegramHelper.js" as TelegramHelper

MessageMediaItem
{
    id: messagedocument
    height: row.height
    width: Math.min(messageitem.width, row.width)
    telegramFile: telegramMessage.media.document.location

    Row
    {
        id: row
        anchors { left: parent.left; top: parent.top }
        height: imgpreview.height
        width: imgpreview.width + info.width
        spacing: Theme.paddingSmall

        MessageThumbnail
        {
            id: imgpreview

            transferInProgress: {
                if(telegramMessage.media.document.attributes.isSticker)
                    return false;

                return telegramMessage.media.document.location.downloading;
            }

            source: {
                if(telegramMessage.media.document.attributes.isSticker)
                    return "image://theme/icon-m-other"; // FIXME: WebP not supported by SailfishOS

                if(!telegramMessage.media.document.thumb.downloaded)
                    telegramMessage.media.document.thumb.download();

                return telegramMessage.media.document.thumb.filePath;
            }
        }

        Column
        {
            id: info
            width: Math.max(lblinfo.paintedWidth, sizemimerow.width)
            height: imgpreview.height

            Label
            {
                id: lblinfo
                height: parent.height / 2
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraSmall
                text: telegramMessage.media.document.attributes.fileName
                wrapMode: Text.NoWrap
                elide: Text.ElideRight
            }

            Row
            {
                id: sizemimerow
                height: parent.height / 2
                spacing: Theme.paddingMedium

                Label
                {
                    id: lblsize
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: TelegramHelper.formatBytes(telegramMessage.media.document.size, 2)
                }

                Label
                {
                    id: lblmime
                    font.pixelSize: Theme.fontSizeExtraSmall
                    text: telegramMessage.media.document.mimeType
                }
            }
        }
    }
}
