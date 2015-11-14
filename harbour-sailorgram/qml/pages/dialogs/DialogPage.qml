import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../components"
import "../../items/peer"
import "../../items/dialog"
import "../../items/message"
import "../../items/message/messageitem"

Page
{
    property Context context
    property Dialog telegramDialog

    id: dialogpage
    allowedOrientations: defaultAllowedOrientations

    onStatusChanged: {
        if(status !== PageStatus.Active)
            return;

        pageStack.pushAttached(Qt.resolvedUrl("DialogInfoPage.qml"), { "context": dialogpage.context, "telegramDialog": dialogpage.telegramDialog });
        //context.foregroundDialog = dialogpage.dialog;
    }

    RemorsePopup { id: remorsepopup }

    PopupMessage
    {
        id: popupmessage
        anchors { left: parent.left; top: parent.top; right: parent.right }
    }

    BusyIndicator
    {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: dialogmodel.busy
        z: running ? 2 : 0
    }

    PeerItem
    {
        id: header
        visible: !context.chatheaderhidden
        anchors { left: parent.left; top: parent.top; right: parent.right; leftMargin: Theme.horizontalPageMargin; topMargin: context.chatheaderhidden ? 0 : Theme.paddingMedium }
        height: context.chatheaderhidden ? 0 : (dialogpage.isPortrait ? Theme.itemSizeSmall : Theme.itemSizeExtraSmall)
        telegramDialog: dialogpage.telegramDialog
    }

    MessageView
    {
        id: messageview
        anchors { left: parent.left; top: header.bottom; right: parent.right; bottom: parent.bottom }
        context: dialogpage.context

        model: DialogModel {
            id: dialogmodel
            telegram: context.telegram
            dialog: dialogpage.telegramDialog
        }

        delegate: MessageItem {
            context: dialogpage.context
            telegramMessage: message
            telegramFromUser: fromUser
        }

        header: Item {
            width: messageview.width
            height: dialogtextinput.height
        }

        Column {
            id: headerarea
            y: messageview.headerItem.y
            parent: messageview.contentItem
            width: parent.width

            DialogTextInput {
                id: dialogtextinput
                width: parent.width
                context: dialogpage.context
            }
        }
    }
}
