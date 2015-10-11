import QtQuick 2.1
import harbour.sailorgram.Telegram 1.0
import "../../../models"
import "../../../js/TelegramConstants.js" as TelegramConstants

Item
{
    property Context context
    property Message telegramMessage

    readonly property bool isUpload: false //telegramMessage.upload.fileId !== 0
    readonly property bool hasMedia: telegramMessage.isMedia && !telegramMessage.media.isEmpty
    readonly property real progressPercent: 0 //isUpload ? (100 * telegramMessage.upload.uploaded / telegramMessage.upload.totalSize) : filehandler.progressPercent

    readonly property bool transferInProgress: {
        var media = telegramMessage.media;

        if(!media)
            return false;

        if(media.isPhoto)
            return media.photo.photoSmall.downloading || media.photo.photoBig.downloading;

        return false;
    }

    readonly property real mediaSize: {
        /*
        if(isUpload)
            return message.upload.totalSize;
        */

        var media = telegramMessage.media;

        if(!media)
            return 0;

        if(media.isPhoto)
            return telegramMessage.media.photo.photoBigSize;

        /*
        if((telegramMessage.media.classType === TelegramConstants.typeMessageMediaPhoto) && telegramMessage.media.photo.sizes.last)
            return telegramMessage.media.photo.sizes.last.size;
        else if(telegramMessage.media.classType === TelegramConstants.typeMessageMediaVideo)
            return telegramMessage.media.video.size;
        else if(telegramMessage.media.classType === TelegramConstants.typeMessageMediaAudio)
            return telegramMessage.media.audio.size;
        else if(telegramMessage.media.classType === TelegramConstants.typeMessageMediaDocument)
            return telegramMessage.media.document.size;
        */

        return 0;
    }

    readonly property string mediaThumbnail: {
        var media = telegramMessage.media;

        if(!media)
            return "";

        //FIXME: if(context.telegram.documentIsSticker(telegramMessage.media.document))
            //return "image://theme/icon-m-other"; //FIXME: WebP: Not Supported

        if(!media.photo.photoSmall.downloaded)
            media.photo.photoSmall.download();

        return media.photo.photoSmall.filePath;
    }

    function cancelTransfer() {
        if(isUpload) {
            //telegram.cancelSendGet(telegramMessage.upload.fizeileId);
            return;
        }

        //filehandler.cancelProgress();
    }

    function download() {
        if(isUpload)
            return;

        var media = telegramMessage.media;

        if(media.isPhoto)
            media.photo.photoBig.download();
    }

    id: messagemediaitem
    visible: hasMedia
}
