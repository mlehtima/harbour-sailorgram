import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../items/peer"
import "../../js/TelegramHelper.js" as TelegramHelper
import "../../js/TelegramAction.js" as TelegramAction

Item
{
    property Dialog telegramDialog

    id: dialogitem

    Row
    {
        anchors { left: parent.left; top: parent.top; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
        spacing: Theme.paddingSmall

        PeerImage
        {
            id: conversationimage
            width: dialogitem.height
            height: dialogitem.height
            fallbackText: telegramDialog.title
        }

        Column
        {
            width: parent.width - conversationimage.width
            anchors { top: parent.top; bottom: parent.bottom }

            Row
            {
                height: dialogitem.height / 2
                anchors { left: parent.left; right: parent.right; rightMargin: Theme.paddingMedium }
                spacing: Theme.paddingSmall

                Image {
                    id: imgchat
                    width: lbltitle.contentHeight
                    height: lbltitle.contentHeight
                    visible: telegramDialog.isChat
                    source: telegramDialog.isChat ? "image://theme/icon-s-chat" : ""
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: lbltitle
                    text: telegramDialog.title
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    color: Theme.highlightColor

                }

                Image {
                    id: imgmute
                    width: Theme.iconSizeSmall
                    height: Theme.iconSizeSmall
                    visible: false // conversationitem.muted
                    source: "image://theme/icon-m-speaker-mute"
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: lbltime
                    height: parent.height
                    font.pixelSize: Theme.fontSizeTiny
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    text: TelegramHelper.printableDate(telegramDialog.topMessage.date)

                    width: {
                        var w = parent.width - lbltitle.contentWidth;

                        if(imgchat.visible)
                            w -= imgchat.width + (Theme.paddingSmall * 2);
                        else
                            w -= Theme.paddingSmall;

                        if(imgmute.visible)
                            w -= imgmute.width + (Theme.paddingSmall * 2);
                        else
                            w -= Theme.paddingSmall;

                        return w;
                    }

                }
            }

            Row
            {
                height: dialogitem.height / 2
                anchors { left: parent.left; right: parent.right; rightMargin: Theme.paddingMedium }

                Label
                {
                    id: lbllastmessage
                    width: parent.width - rectunread.width
                    height: parent.height
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeExtraSmall
                    font.italic: telegramDialog.topMessage.isService

                    text: {
                        if(telegramDialog.topMessage.isMedia)
                            return TelegramHelper.mediaType(telegramDialog.topMessage.media);

                        return telegramDialog.topMessage.message;
                    }
                }

                Rectangle
                {
                    id: rectunread
                    width: parent.height
                    height: parent.height
                    color: Theme.secondaryHighlightColor
                    visible: telegramDialog.unreadCount > 0
                    radius: width * 0.5

                    Label
                    {
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeTiny
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        text: telegramDialog.unreadCount
                    }
                }
            }
        }
    }
}
