pragma Singleton
import qs.utils
import QtQuick
import Quickshell
import Quickshell.Io
Singleton {
    id: root
    
    property alias primary: ad.primary
    property alias textPrimary: ad.textPrimary
    property alias primaryContainer: ad.primaryContainer
    property alias textPrimaryContainer: ad.textPrimaryContainer
    property alias secondary: ad.secondary
    property alias secondaryContainer: ad.secondaryContainer
    property alias tertiary: ad.tertiary
    property alias tertiaryContainer: ad.tertiaryContainer
    property alias textTertiary: ad.textTertiary
    property alias textTertiaryContainer: ad.textTertiaryContainer
    property alias textSecondary: ad.textSecondary
    property alias textSecondaryContainer: ad.textSecondaryContainer
    property alias surfaceContainerLow: ad.surfaceContainerLow
    property alias surfaceContainer: ad.surfaceContainer
    property alias surfaceContainerHigh: ad.surfaceContainerHigh
    property alias surfaceContainerHighest: ad.surfaceContainerHighest
    property alias textSurface: ad.textSurface
    property alias textSurfaceVariant: ad.textSurfaceVariant
    property alias tooltip: ad.tooltip
    property alias textTooltip: ad.textTooltip
    property alias scrim: ad.scrim
    property alias shadow: ad.shadow
    property alias outline: ad.outline
    property alias outlineVariant: ad.outlineVariant
    property alias error: ad.error
    property alias textError: ad.textError
    property alias errorContainer: ad.errorContainer
    property alias textErrorContainer: ad.textErrorContainer

    ElapsedTimer {
        id: timer
    }

    FileView{
        path: `${Paths.config}/colours.json`
        watchChanges: true
        onFileChanged: {
            timer.restart();
            reload();
        }
        onLoaded: {
            try {
                JSON.parse(text());
                if (root.primary){
                    // Toaster.toast(qsTr("Config loaded"), qsTr("Config loaded in %1ms").arg(timer.elapsedMs()), "rule_settings");
                    console.log(`Colour Config loaded in ${timer.elapsedMs()}ms`);

                }
            } catch (e) {
                // Toaster.toast(qsTr("Failed to load config"), e.message, "settings_alert", Toast.Error);
                console.warn("Failed to load config file:", e.message);
            }
        }
        onLoadFailed: err => {
            if (err !== FileViewError.FileNotFound)
                // Toaster.toast(qsTr("Failed to read config file"), FileViewError.toString(err), "settings_alert", Toast.Warning);
                console.warn("Failed to read config file:", FileViewError.toString(err));
        }
        onSaveFailed: err => {
            // Toaster.toast(qsTr("Failed to save config"), FileViewError.toString(err), "settings_alert", Toast.Error)
            console.warn("Failed to save config file:", FileViewError.toString(err));
        }
    
        JsonAdapter {
            id: ad
            property color primary: "#D8BAFB"
            property color textPrimary: "#3C255A"
            property color primaryContainer: "#533B72"
            property color textPrimaryContainer: "#EEDCFF"
            property color secondary: "#CFC1DA"
            property color secondaryContainer: "#4C4357"
            property color tertiary: "#F2B7C1"
            property color tertiaryContainer: "#653B43"
            property color textTertiary: "#653B43"
            property color textTertiaryContainer: "#653B43"
            property color textSecondary: "#653B43"
            property color textSecondaryContainer: "#EBDDF7"
            property color surfaceContainerLow: "#1D1A20"
            property color surfaceContainer: "#211E24"
            property color surfaceContainerHigh: "#2C292F"
            property color surfaceContainerHighest: "#373339"
            property color textSurface: "#E7E0E8"
            property color textSurfaceVariant: "#CCC4CF"
            property color tooltip: "#4A454E"
            property color textTooltip: "#CCC4CF"
            property color scrim: "#000000"
            property color shadow: "#000000"
            property color outline: "#958E99"
            property color outlineVariant: "#4A454E"
            property color error: "#FFB4AB"
            property color textError: "#690005"
            property color errorContainer: "#93000A"
            property color textErrorContainer: "#FFDAD6"
        }
    }


}
