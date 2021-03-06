import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../../components"
import "../../../js/TextElaborator.js" as TextElaborator

ResizableLabel
{
    property bool openUrls: true
    property string emojiPath
    property string rawText

    id: messagetextcontent
    textFormat: Text.StyledText
    text: TextElaborator.elaborate(rawText, emojiPath, font.pixelSize, linkColor, openUrls)

    onLinkActivated: {
        if(!openUrls)
            return;

        Qt.openUrlExternally(link);
    }
}
