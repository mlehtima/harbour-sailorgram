import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../models"
import "../../components"
import "../../js/Settings.js" as Settings

Page
{
    property Context context

    id: connectionpage
    allowedOrientations: defaultAllowedOrientations

    onStatusChanged: {
        if(forwardNavigation || (connectionpage.status !== PageStatus.Active))
            return;

        if(!context.telegram.dcConnected)
            context.telegram.connectToDC(context.apiAddress, context.apiPort, context.dcId);
    }

    Row
    {
        anchors { top: parent.top; right: parent.right }
        height: csitem.height

        Label
        {
            text: qsTr("Telegram Status")
            anchors.verticalCenter: csitem.verticalCenter
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignLeft
            font.family: Theme.fontFamilyHeading
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
        }

        ConnectionStatus
        {
            id: csitem
            context: connectionpage.context
        }
    }

    Label
    {
        anchors { bottom: indicator.top; bottomMargin: Theme.paddingMedium }
        width: parent.width
        font.pixelSize: Theme.fontSizeExtraLarge
        horizontalAlignment: Text.AlignHCenter
        color: Theme.secondaryHighlightColor
        text: qsTr("Connecting")
    }

    BusyIndicator
    {
        id: indicator
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: true
    }
}
