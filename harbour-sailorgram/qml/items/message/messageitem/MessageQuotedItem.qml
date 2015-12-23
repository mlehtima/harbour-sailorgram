import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.TelegramQml 1.0
import "../../../models"
import "../../../js/ColorScheme.js" as ColorScheme
import "../../../js/TelegramHelper.js" as TelegramHelper
import "../../../js/TelegramAction.js" as TelegramAction

Item
{
    property Context context
    property Message message
    property Message replyToMessage: context.telegram.message(message.replyToMsgId)
    property real calculatedWidth: Math.max(dummytextcontent.contentWidth, lbluser.contentWidth)

    id: messagequoteditem
    height: column.height

    Text
    {
        id: dummytextcontent
        visible: false
        font.pixelSize: mtctextcontent.font.pixelSize
        font.italic: mtctextcontent.font.italic
        text: mtctextcontent.rawText
    }

    Row
    {
        id: row
        anchors.fill: parent
        spacing: Theme.paddingSmall

        Rectangle
        {
            color: Theme.secondaryHighlightColor
            width: Theme.paddingSmall
            height: parent.height
        }

        Column
        {
            id: column
            width: parent.width - (Theme.paddingSmall * 2)

            Label
            {
                id: lbluser
                width: parent.width
                visible: !TelegramHelper.isServiceMessage(replyToMessage)
                color: ColorScheme.colorize(message, context)
                font.bold: true
                font.pixelSize: Theme.fontSizeTiny
                wrapMode: Text.NoWrap
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter

                text: {
                    if(TelegramHelper.isServiceMessage(replyToMessage))
                        return "";

                    if(message.out)
                        return qsTr("You");

                    return TelegramHelper.completeName(context.telegram.user(replyToMessage.fromId))
                }
            }

            MessageTextContent
            {
                id: mtctextcontent
                font.pixelSize: Theme.fontSizeExtraSmall
                font.italic: true
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                emojiPath: context.sailorgram.emojiPath
                rawText: TelegramHelper.isServiceMessage(replyToMessage) ? TelegramAction.actionType(context.telegram, dialog, replyToMessage) : replyToMessage.message
                verticalAlignment: Text.AlignTop
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                maximumLineCount: 3
                visible: text.length > 0
                color: ColorScheme.colorize(message, context)
                linkColor: ColorScheme.colorizeLink(message, context)
            }
        }
    }
}

