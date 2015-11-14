import QtQuick 2.1
import harbour.sailorgram.Telegram 1.0
import "../../../../models"
import "../../../../js/TelegramConstants.js" as TelegramConstants

Item
{
    property Context context
    property Message telegramMessage
    property File telegramFile

    readonly property bool isUpload: telegramMessage.isOut
    readonly property bool hasMedia: telegramMessage.isMedia && !telegramMessage.media.isEmpty

    function download() {
        if(isUpload)
            return;

        if(telegramMessage.media.isPhoto)
            telegramMessage.media.photo.photoBig.download();
        else if(telegramMessage.media.isDocument)
            telegramMessage.media.document.location.download();
        else if(telegramMessage.media.isAudio)
            telegramMessage.media.audio.location.download();
        else if(telegramMessage.media.isVideo)
            telegramMessage.media.video.location.download();
    }

    id: messagemediaitem
    visible: hasMedia
}
