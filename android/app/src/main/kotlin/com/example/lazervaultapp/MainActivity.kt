package com.example.lazervaultapp

import android.nfc.NfcAdapter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // Check if NFC is available before registering plugins
        val nfcAvailable = isNfcAvailable()

        // Register all plugins
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // Log NFC status for debugging
        if (nfcAvailable) {
            android.util.Log.i("MainActivity", "NFC hardware detected and plugin registered")
        } else {
            android.util.Log.i("MainActivity", "No NFC hardware - NFC plugin will be disabled at runtime")
        }
    }

    private fun isNfcAvailable(): Boolean {
        return try {
            val nfcAdapter = NfcAdapter.getDefaultAdapter(this)
            nfcAdapter != null
        } catch (e: Exception) {
            android.util.Log.w("MainActivity", "Error checking NFC availability", e)
            false
        }
    }
}
