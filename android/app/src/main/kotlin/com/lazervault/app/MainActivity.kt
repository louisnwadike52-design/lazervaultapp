package com.lazervault.app

import android.content.Intent
import android.nfc.NdefMessage
import android.nfc.NdefRecord
import android.nfc.NfcAdapter
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val hceChannelName = "com.lazervault.app/hce"
    private val settingsChannelName = "com.lazervault.app/settings"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // --- HCE control (Host Card Emulation for contactless "broadcast") -----
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, hceChannelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isHceSupported" -> result.success(isHceSupported())

                    // Load the payment session into the emulated NDEF tag and
                    // start being readable. We build the NDEF Text record here so
                    // it byte-for-byte matches what the reader screen expects
                    // (a well-known Text record: payer strips the language prefix).
                    "startBroadcast" -> {
                        val payload = call.argument<String>("payload")
                        if (payload.isNullOrEmpty()) {
                            result.error("EMPTY_PAYLOAD", "payload is required", null)
                            return@setMethodCallHandler
                        }
                        if (!isHceSupported()) {
                            result.success(false)
                            return@setMethodCallHandler
                        }
                        try {
                            val ndef = NdefMessage(NdefRecord.createTextRecord("en", payload))
                            LazerVaultHostApduService.ndefMessage = ndef.toByteArray()
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("HCE_START_FAILED", e.message, null)
                        }
                    }

                    // Stop being readable (receiver screen closed / session done).
                    "stop" -> {
                        LazerVaultHostApduService.ndefMessage = null
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }

        // --- misc settings deep-links (used by the reader screen) --------------
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, settingsChannelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "openNfcSettings" -> {
                        try {
                            startActivity(Intent(Settings.ACTION_NFC_SETTINGS))
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("OPEN_FAILED", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /** HCE works only on a device with the HCE feature AND NFC turned on. */
    private fun isHceSupported(): Boolean {
        if (!packageManager.hasSystemFeature("android.hardware.nfc.hce")) return false
        val adapter = NfcAdapter.getDefaultAdapter(this) ?: return false
        return adapter.isEnabled
    }
}
