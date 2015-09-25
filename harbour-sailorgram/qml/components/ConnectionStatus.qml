import QtQuick 2.1
import Sailfish.Silica 1.0
import "../models"

GlassItem
{
    property bool forceActive: false
    property Context context

    id: connectionstatus
    color: forceActive || context.telegram.dcConnected ? "lime" : "red"
}
