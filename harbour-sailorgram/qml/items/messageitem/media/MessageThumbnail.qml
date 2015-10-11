import QtQuick 2.1
import Sailfish.Silica 1.0

Item
{
    property alias source: image.source
    property bool transferInProgress: false
    property size imageSize

    id: messagethumbnail
    width: image.width
    height: image.height

    Image
    {
        id: image
        smooth: true
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        height: Theme.iconSizeLarge
        width: height ? (height * imageSize.width / imageSize.height) : Theme.iconSizeLarge
        sourceSize: Qt.size(width, height)
        visible: !transferInProgress && (image.status === Image.Ready)
    }

    BusyIndicator
    {
        id: busyindicator
        anchors.centerIn: parent
        width: Theme.iconSizeLarge - Theme.paddingSmall
        height: Theme.iconSizeLarge - Theme.paddingSmall
        running: transferInProgress || (image.status !== Image.Ready)
    }
}
