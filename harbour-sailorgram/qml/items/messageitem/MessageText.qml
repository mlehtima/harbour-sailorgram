import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../js/TelegramHelper.js" as TelegramHelper
import "../../js/TelegramAction.js" as TelegramAction

Item
{
    property Message telegramMessage

    id: messagetext
    height: content.height

    Column
    {
        id: content
        anchors.top: parent.top
        width: parent.width
        spacing: Theme.paddingSmall

        Label
        {
            id: lbltext
            anchors { left: telegramMessage.isOut ? parent.left : undefined; right: telegramMessage.isOut ? undefined : parent.right }
            width: parent.width
            color: telegramMessage.isService ? Theme.primaryColor : (telegramMessage.isOut ? Theme.highlightColor : Theme.primaryColor)
            font.pixelSize: telegramMessage.isService ? Theme.fontSizeExtraSmall : Theme.fontSizeSmall
            font.italic: telegramMessage.isService
            horizontalAlignment: telegramMessage.isService ? Text.AlignHCenter : (telegramMessage.isOut ? Text.AlignLeft : Text.AlignRight)
            text: telegramMessage.isService ? TelegramHelper.serviceType(telegramMessage, dialogmodel) : telegramMessage.message
            verticalAlignment: Text.AlignTop
            wrapMode: Text.WordWrap
            visible: text.length > 0
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
            }
        }
    }
}
