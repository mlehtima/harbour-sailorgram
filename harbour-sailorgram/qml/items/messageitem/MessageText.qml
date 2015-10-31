import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../js/TelegramHelper.js" as TelegramHelper

Item
{
    property Context context
    property Message telegramMessage
    property real calculatedWidth: Math.max(mtctextcontent.paintedWidth, (msgstatus.width + lbldate.paintedWidth))

    id: messagetext
    height: content.height

    Column
    {
        id: content
        anchors.top: parent.top
        width: parent.width
        spacing: Theme.paddingSmall

        MessageTextContext
        {
            id: mtctextcontent
            anchors { left: telegramMessage.isOut ? parent.left : undefined; right: telegramMessage.isOut ? undefined : parent.right }
            width: parent.width
            font.pixelSize: telegramMessage.isService ? Theme.fontSizeExtraSmall : Theme.fontSizeSmall
            font.italic: telegramMessage.isService
            horizontalAlignment: telegramMessage.isService ? Text.AlignHCenter : (telegramMessage.isOut ? Text.AlignLeft : Text.AlignRight)
            emojiPath: context.sailorgram.emojiPath
            rawText: telegramMessage.isService ? TelegramHelper.serviceType(telegramMessage, dialogmodel) : telegramMessage.message
            verticalAlignment: Text.AlignTop
            wrapMode: Text.WordWrap
            visible: text.length > 0

            color: {
                 if(telegramMessage.isOut)
                     return Theme.highlightDimmerColor;

                 return Theme.primaryColor;
            }
        }

        Row
        {
            anchors { right: telegramMessage.isOut ? undefined : parent.right; left: telegramMessage.isOut ? parent.left : undefined }
            spacing: Theme.paddingSmall

            MessageStatus
            {
                id: msgstatus
                width: lbldate.contentHeight
                height: lbldate.contentHeight
                telegramMessage: messagetext.telegramMessage
            }

            Label
            {
                id: lbldate
                font.pixelSize: Theme.fontSizeTiny
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: telegramMessage.isOut ? Text.AlignLeft : Text.AlignRight
                text: TelegramHelper.printableDate(telegramMessage.date)
                visible: !telegramMessage.isService

                color: {
                    if(telegramMessage.isOut || telegramMessage.isService)
                        return Theme.highlightDimmerColor;

                    return Theme.primaryColor;
                }
            }
        }
    }
}
