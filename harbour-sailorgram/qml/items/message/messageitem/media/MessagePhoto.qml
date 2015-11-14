import QtQuick 2.1
import Sailfish.Silica 1.0

MessageMediaItem
{
    id: messagephoto
    width: thumb.width
    height: thumb.height
    telegramFile: telegramMessage.media.photo.photoBig

    MessageThumbnail
    {
        id: thumb
        anchors { left: parent.left; top: parent.top }
        imageSize: telegramMessage.media.photo.photoSmallImageSize
        transferInProgress: telegramMessage.media.photo.photoSmall.downloading

        source: {
            if(!telegramMessage.media.photo.photoSmall.downloaded)
                telegramMessage.media.photo.photoSmall.download();

            return telegramMessage.media.photo.photoSmall.filePath;
        }
    }
}
