import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../items/peer"
import "../../js/TelegramHelper.js" as TelegramHelper
import "../../js/TelegramAction.js" as TelegramAction

Item
{
    property Context context
    property string dialogTitle
    property string lastMessage
    property int unreadCount: 0
    property bool muted: false

    id: conversationitem

    Row
    {
        anchors { left: parent.left; top: parent.top; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
        spacing: Theme.paddingSmall

        PeerImage
        {
            id: conversationimage
            width: conversationitem.height
            height: conversationitem.height
            fallbackText: conversationitem.dialogTitle
        }

        Column
        {
            width: parent.width - conversationimage.width
            anchors { top: parent.top; bottom: parent.bottom }

            Row
            {
                height: conversationitem.height / 2
                anchors { left: parent.left; right: parent.right; rightMargin: Theme.paddingMedium }
                spacing: Theme.paddingSmall

                Image {
                    id: imgchat
                    width: lbltitle.contentHeight
                    height: lbltitle.contentHeight
                    visible: false //TelegramHelper.isChat(dialog)
                    source: "" //TelegramHelper.isChat(dialog) ? "image://theme/icon-s-chat" : ""
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: lbltitle
                    text: dialogTitle
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
                    text: "00:00" //TelegramCalendar.timeToString(message.date)

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
                height: conversationitem.height / 2
                anchors { left: parent.left; right: parent.right; rightMargin: Theme.paddingMedium }

                Label
                {
                    id: lbllastmessage
                    width: parent.width - rectunread.width
                    height: parent.height
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeExtraSmall
                    //font.italic: TelegramHelper.isActionMessage(message)
                    text: conversationitem.lastMessage
                }

                Rectangle
                {
                    id: rectunread
                    width: parent.height
                    height: parent.height
                    color: Theme.secondaryHighlightColor
                    visible: conversationitem.unreadCount > 0
                    radius: width * 0.5

                    Label
                    {
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeTiny
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        text: conversationitem.unreadCount
                    }
                }
            }
        }
    }
}
