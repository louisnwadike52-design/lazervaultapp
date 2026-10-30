package com.lazervault.app

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.service.quicksettings.TileService
import android.service.quicksettings.Tile
import android.util.Log

/**
 * Quick Settings tile that appears in the Android notification shade.
 * Tapping it launches the app's "Scan to Pay" flow via deep link,
 * which is the most common quick-pay use case from the notification shade.
 */
class QuickPayTileService : TileService() {

    companion object {
        private const val TAG = "QuickPayTileService"
        private const val QUICK_PAY_URI = "lazervault://quick-action/scan_to_pay"
    }

    override fun onStartListening() {
        super.onStartListening()
        qsTile?.let { tile ->
            tile.state = Tile.STATE_INACTIVE
            tile.label = getString(R.string.quick_pay_tile_label)
            tile.updateTile()
        }
    }

    override fun onClick() {
        super.onClick()
        Log.i(TAG, "Quick Pay tile tapped")

        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(QUICK_PAY_URI)).apply {
            setPackage(packageName)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
        }

        // NEVER THROW OUT OF onClick. A TileService that crashes is killed by
        // the system and the user sees a dead tile in their quick settings —
        // a worse outcome than the tap simply not working. Two things here can
        // throw and neither is in our control at tap time:
        //
        //  - ActivityNotFoundException, if nothing resolves
        //    lazervault://quick-action/scan_to_pay. It resolves today via the
        //    scheme filter in AndroidManifest.xml, but a manifest change is
        //    exactly the sort of edit that breaks it silently.
        //  - On API 34+, startActivityAndCollapse(Intent) itself throws
        //    UnsupportedOperationException. That is handled by the version
        //    branch below, but the branch is the only thing standing between
        //    us and a guaranteed crash, so it is worth a net underneath it.
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                startActivityAndCollapse(android.app.PendingIntent.getActivity(
                    this, 0, intent,
                    android.app.PendingIntent.FLAG_UPDATE_CURRENT or android.app.PendingIntent.FLAG_IMMUTABLE
                ))
            } else {
                @Suppress("DEPRECATION")
                startActivityAndCollapse(intent)
            }
        } catch (e: Throwable) {
            Log.e(TAG, "Quick Pay tile could not launch the app", e)
        }
    }
}
