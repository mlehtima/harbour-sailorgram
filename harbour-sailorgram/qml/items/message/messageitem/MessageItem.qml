import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../../models"
import "../../../menus"
import "media"
import "../../../js/TelegramHelper.js" as TelegramHelper

ListItem
{
    property Context context
    property Message telegramMessage
    property User telegramFromUser

    function remorseNeeded(media) {
        if(loader.item.telegramFile.downloaded) // No remorse for downloaded medias
            return false;

        if(media.isVideo || media.isAudio)
            return true;

        if(media.isDocument && (media.document.attributes.isAudio || media.document.attributes.isVideo))
            return true;

        if(media.isDocument && media.document.attributes.isImage)
            return true;

        return false;
    }

    function openOrDownloadMedia(canbeviewed) {
        if(!loader.item.telegramFile.downloaded)
            loader.item.telegramFile.download();

        if((telegramMessage.media.isPhoto) || (telegramMessage.media.isDocument && telegramMessage.media.document.attributes.isImage)) {
            pageStack.push(Qt.resolvedUrl("../../pages/media/MediaPhotoPage.qml"), { "context": messageitem.context, "telegramFile": loader.item.telegramFile });
            return;
        }

        if(telegramMessage.media.isAudio || (telegramMessage.media.isDocument && telegramMessage.media.document.attributes.isAudio)) {
            if(telegramMessage.media.isAudio)
                pageStack.push(Qt.resolvedUrl("../../pages/media/MediaPlayerPage.qml"), { "context": messageitem.context, "telegramFile": loader.item.telegramFile });
            else
                pageStack.push(Qt.resolvedUrl("../../pages/media/MediaPlayerPage.qml"), { "context": messageitem.context, "telegramFile": loader.item.telegramFile });

            return;
        }

        if(telegramMessage.media.isVideo || (telegramMessage.media.isDocument && telegramMessage.media.document.attributes.isVideo)) {
            if(telegramMessage.media.isVideo) {
                pageStack.push(Qt.resolvedUrl("../../pages/media/MediaPlayerPage.qml"), { "context": messageitem.context, "telegramFile": loader.item.telegramFile,
                                                                                          "videoCaption": telegramMessage.media.video.caption,
                                                                                          "mediaThumbnail": telegramMessage.media.video.thumb });
            }
            else
                pageStack.push(Qt.resolvedUrl("../../pages/media/MediaPlayerPage.qml"), { "context": messageitem.context, "telegramFile": loader.item.telegramFile });

            return;
        }

        if(!loader.item.telegramFile.downloaded)
            return;

        popupmessage.show(qsTr("Opening media"));
        Qt.openUrlExternally(loader.item.telegramFile.filePath);
    }

    function displayMedia() {
        if(!telegramMessage.media)
            return;

        var canbeviewed = telegramMessage.media.isPhoto || telegramMessage.media.isAudio || telegramMessage.media.isVideo;

        if(telegramMessage.media.isDocument) {
            var attributes = telegramMessage.media.document.attributes;
            canbeviewed = attributes.isVideo || attributes.isAudio || attributes.isImage;
        }

        if(!remorseNeeded(telegramMessage.media)) {
            openOrDownloadMedia(canbeviewed);
            return;
        }

        messageitem.remorseAction((canbeviewed ? qsTr("Opening Media") : qsTr("Downloading Media")), function() {
            openOrDownloadMedia(canbeviewed);
        });
    }

    id: messageitem
    contentWidth: parent.width
    contentHeight: content.height

    menu: MessageMenu {
        id: messagemenu
        telegramMessage: messageitem.telegramMessage
        loaderItem: loader.item

        onDownloadRequested: loader.item.download()
        onDeleteRequested: dialogmodel.deleteMessage(messageitem.telegramMessage)
        onCancelRequested: loader.item.cancelTransfer()
    }

    onClicked: displayMedia()

    Component {
        id: documentcomponent

        MessageDocument {
            context: messageitem.context
            telegramMessage: messageitem.telegramMessage
        }
    }

    Component {
        id: photocomponent

        MessagePhoto {
            context: messageitem.context
            telegramMessage: messageitem.telegramMessage
        }
    }

    Component {
        id: audiocomponent

        MessageAudio {
            context: messageitem.context
            telegramMessage: messageitem.telegramMessage
        }
    }

    Component {
        id: videocomponent

        MessageVideo {
            context: messageitem.context
            telegramMessage: messageitem.telegramMessage
        }
    }

    Rectangle
    {
        anchors {
            left: telegramMessage.isOut ? parent.left : undefined;
            right: telegramMessage.isOut ? undefined : parent.right
            leftMargin: telegramMessage.isOut ? Theme.paddingMedium : 0
            rightMargin: telegramMessage.isOut ? 0 : Theme.paddingMedium
        }

        radius: 10

        width: {
            if(telegramMessage.isService)
                return 0;

            if(telegramMessage.isMedia)
                return Math.max(lbluser.width, loader.width) + Theme.paddingMedium;

            return Math.max(lbluser.width, messagetext.calculatedWidth) + Theme.paddingMedium;
        }

        height: {
            if(telegramMessage.isService)
                return 0;

            var h = lbluser.height + messagetext.height + Theme.paddingSmall;

            if(telegramMessage.isMedia)
                h += loader.height;

            return h;
        }

        color: {
            if(telegramMessage.isService)
                return "transparent"

            if(telegramMessage.isOut)
                return Theme.secondaryColor;

            return Theme.rgba(Qt.tint(Theme.secondaryHighlightColor, Theme.rgba(Theme.highlightDimmerColor, 0.3)), 0.7);
        }
    }

    Column
    {
        id: content
        anchors { top: parent.top; left: parent.left; right: parent.right; leftMargin: Theme.paddingMedium; rightMargin: Theme.paddingMedium }

        Label
        {
            id: lbluser
            anchors { left: telegramMessage.isOut ? parent.left : undefined; right: telegramMessage.isOut ? undefined : parent.right }
            visible: !telegramMessage.isService
            font.bold: true
            font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.NoWrap
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter

            color: {
                if(telegramMessage.isOut)
                    return Theme.rgba(Theme.highlightDimmerColor, 1.0);

                return Theme.rgba(Theme.secondaryColor, 1.0);
            }

            text: {
                if(telegramMessage.isService)
                    return "";

                if(telegramMessage.isOut)
                    return qsTr("You");

                return TelegramHelper.fullName(telegramFromUser);
            }
        }

        Loader
        {
            id: loader
            anchors { left: telegramMessage.isOut ? parent.left : undefined; right: telegramMessage.isOut ? undefined : parent.right }

            sourceComponent: {
                if(telegramMessage.isMedia) {
                    if(telegramMessage.media.isPhoto)
                        return photocomponent;
                    else if(telegramMessage.media.isDocument)
                        return documentcomponent;
                    else if(telegramMessage.media.isAudio)
                        return audiocomponent;
                    else if(telegramMessage.media.isVideo)
                        return videocomponent;
                }

                return null;
            }
        }

        MessageText
        {
            id: messagetext
            width: parent.width
            context: messageitem.context
            telegramMessage: messageitem.telegramMessage
        }
    }
}
