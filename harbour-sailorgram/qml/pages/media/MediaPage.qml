import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"

Page
{
    readonly property bool isMediaPage: true
    property Context context
    property Message message
    property FileHandler fileHandler
}
