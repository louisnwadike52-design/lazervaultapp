package com.lazervault.app

import android.app.ActivityManager
import android.app.ApplicationExitInfo
import android.content.Intent
import android.hardware.biometrics.BiometricManager
import android.hardware.fingerprint.FingerprintManager
import android.nfc.NdefMessage
import android.nfc.NdefRecord
import android.nfc.NfcAdapter
import android.os.Build
import android.provider.Settings
// local_auth (fingerprint / face unlock) REQUIRES the host activity to be a
// FragmentActivity so it can attach the BiometricPrompt. With plain
// FlutterActivity, getAvailableBiometrics()/authenticate() fail and every
// method reports "unavailable". FlutterFragmentActivity is the required base.
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import java.util.concurrent.atomic.AtomicBoolean
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    private val hceChannelName = "com.lazervault.app/hce"
    private val settingsChannelName = "com.lazervault.app/settings"
    private val playServicesChannelName = "com.lazervault.app/play_services"
    private val installReferrerChannelName = "com.lazervault.app/install_referrer"
    private val exitInfoChannelName = "com.lazervault.app/exit_info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // --- WHY THE APP DIED LAST TIME ------------------------------------
        //
        // An ANR is invisible from inside Dart. The app is not crashing — it
        // is alive and not answering, so no Dart error handler fires, nothing
        // reaches runZonedGuarded, and the process is killed by the system
        // with no record on our side. We were counting ANRs from Play Console
        // days later, with no stack and no idea which screen the user was on.
        //
        // ApplicationExitInfo is the only first-party source for this. Android
        // keeps the last several exit reasons per package — ANR, native
        // crash, OOM kill, user action — WITH the ANR trace attached. Reading
        // it at the NEXT launch is how a death that could not be observed as
        // it happened becomes a report.
        //
        // API 30+. Below that the list does not exist and the channel returns
        // empty, which the Dart side treats as "nothing to report" rather
        // than as an error.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, exitInfoChannelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getRecentExits" -> result.success(recentExits())
                    else -> result.notImplemented()
                }
            }

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

                    // Precise biometric readiness so the app can distinguish
                    // "no fingerprint/face enrolled yet" (→ offer to open OS
                    // enrollment) from "no sensor at all". local_auth alone
                    // can't tell these apart (getAvailableBiometrics() is empty
                    // in both cases).
                    "biometricStatus" -> result.success(biometricStatus())

                    // Send the app to the background WITHOUT finishing the
                    // activity, so pressing Back on the dashboard (the root
                    // route) doesn't tear down the task → cold relaunch → login
                    // gate (perceived as "back logged me out"). Keeps the live
                    // session; returning within the inactivity window resumes
                    // straight onto the dashboard.
                    "moveTaskToBack" -> {
                        try {
                            moveTaskToBack(true)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("MOVE_FAILED", e.message, null)
                        }
                    }

                    // Deep-link DOWN to the OS screen where the user enrolls a
                    // fingerprint / face, then returns to enable it in-app.
                    "openBiometricEnroll" -> {
                        try {
                            openBiometricEnroll()
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("OPEN_FAILED", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }

        // --- Google Play Services availability -----------------------------------
        // Returns the raw ConnectionResult code (0 == SUCCESS) so Dart can decide
        // whether to activate Firebase App Check (Play Integrity) + FCM. CRITICAL:
        // we call the query-only isGooglePlayServicesAvailable() and NEVER
        // getErrorDialog()/makeGooglePlayServicesAvailable(), so this check itself
        // never surfaces the native "Something went wrong / update Google Play"
        // dialog. That dialog was blocking app open on devices whose Play
        // Services/Store is missing/outdated; gating on this code lets the app run
        // (without push/attestation) instead of hard-blocking.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, playServicesChannelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "availability" -> {
                        val code = try {
                            GoogleApiAvailability.getInstance()
                                .isGooglePlayServicesAvailable(this)
                        } catch (e: Throwable) {
                            // If the GMS lib can't run at all, don't over-block —
                            // report SUCCESS and let the normal (guarded) init try.
                            ConnectionResult.SUCCESS
                        }
                        result.success(code)
                    }
                    else -> result.notImplemented()
                }
            }

        // Play Install Referrer. Returns the raw referrer string Play recorded
        // at install time, or null.
        //
        // Dart decides what the string MEANS (it parses `ref=<CODE>`); this
        // only fetches it. Keeping the parsing on one side means the website,
        // the deep link and the install referrer all normalise a code through
        // the same Dart code rather than through two implementations that can
        // disagree.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, installReferrerChannelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "fetch" -> fetchInstallReferrer(result)
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Reads the Play install referrer, replying exactly once and never throwing.
     *
     * THREE THINGS THIS HAS TO GET RIGHT, and all three are why it is hand-written:
     *
     *  - REPLY ONCE. A MethodChannel result may be completed a single time;
     *    completing it twice crashes the app. The listener can fire a setup
     *    callback and a disconnect, so an AtomicBoolean gates the reply rather
     *    than trusting the callback to arrive once.
     *  - REPLY ON THE PLATFORM THREAD. Flutter requires it, and the referrer
     *    callback is not guaranteed to be on it.
     *  - NEVER FAIL THE CALLER. Play Store absent, an old Play version, a
     *    sideloaded build, a dead service: every one of those is "no referrer",
     *    not an error. A signup must never be blocked because an attribution
     *    lookup failed, so every path answers null.
     */
    private fun fetchInstallReferrer(result: MethodChannel.Result) {
        val replied = AtomicBoolean(false)
        fun reply(value: String?) {
            if (replied.compareAndSet(false, true)) {
                runOnUiThread { result.success(value) }
            }
        }

        val client = try {
            InstallReferrerClient.newBuilder(this).build()
        } catch (e: Throwable) {
            reply(null)
            return
        }

        try {
            client.startConnection(object : InstallReferrerStateListener {
                override fun onInstallReferrerSetupFinished(responseCode: Int) {
                    var referrer: String? = null
                    try {
                        if (responseCode == InstallReferrerClient.InstallReferrerResponse.OK) {
                            referrer = client.installReferrer.installReferrer
                        }
                    } catch (e: Throwable) {
                        referrer = null
                    } finally {
                        // Always end the connection: the service stays bound
                        // otherwise, and this is a one-shot read.
                        try {
                            client.endConnection()
                        } catch (e: Throwable) {
                            // Nothing useful to do; the reply below still happens.
                        }
                    }
                    reply(referrer)
                }

                override fun onInstallReferrerServiceDisconnected() {
                    // No retry. The referrer is readable for the life of the
                    // install, so the next launch can ask again — far better
                    // than holding a startup path open on a flaky service.
                    reply(null)
                }
            })
        } catch (e: Throwable) {
            reply(null)
        }
    }

    /**
     * Biometric readiness, precise enough to drive the "set it up from our app"
     * flow. Uses the framework [BiometricManager] (API 29/30+) which reports
     * NONE_ENROLLED vs NO_HARDWARE; falls back to [FingerprintManager] on older
     * API levels. Returns one of: "available" | "none_enrolled" | "no_hardware"
     * | "hw_unavailable" | "unavailable".
     */
    private fun biometricStatus(): String {
        // API 30+: canAuthenticate(authenticators) with strong OR weak.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val bm = getSystemService(BiometricManager::class.java)
                ?: return "unavailable"
            val authenticators = BiometricManager.Authenticators.BIOMETRIC_STRONG or
                BiometricManager.Authenticators.BIOMETRIC_WEAK
            return when (bm.canAuthenticate(authenticators)) {
                BiometricManager.BIOMETRIC_SUCCESS -> "available"
                BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> "none_enrolled"
                BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> "no_hardware"
                BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> "hw_unavailable"
                else -> "unavailable"
            }
        }
        // API 29: BiometricManager exists but only the no-arg canAuthenticate().
        if (Build.VERSION.SDK_INT == Build.VERSION_CODES.Q) {
            val bm = getSystemService(BiometricManager::class.java)
                ?: return "unavailable"
            @Suppress("DEPRECATION")
            return when (bm.canAuthenticate()) {
                BiometricManager.BIOMETRIC_SUCCESS -> "available"
                BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> "none_enrolled"
                BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> "no_hardware"
                BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> "hw_unavailable"
                else -> "unavailable"
            }
        }
        // API 23–28: FingerprintManager (USE_FINGERPRINT permission is declared).
        @Suppress("DEPRECATION")
        val fm = try {
            getSystemService(FingerprintManager::class.java)
        } catch (e: Exception) {
            null
        }
        if (fm == null) return "no_hardware"
        return try {
            @Suppress("DEPRECATION")
            when {
                !fm.isHardwareDetected -> "no_hardware"
                !fm.hasEnrolledFingerprints() -> "none_enrolled"
                else -> "available"
            }
        } catch (e: SecurityException) {
            "unavailable"
        }
    }

    /** Open the OS enrollment screen for fingerprint / face. */
    private fun openBiometricEnroll() {
        val intent = when {
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.R ->
                Intent(Settings.ACTION_BIOMETRIC_ENROLL).apply {
                    putExtra(
                        Settings.EXTRA_BIOMETRIC_AUTHENTICATORS_ALLOWED,
                        BiometricManager.Authenticators.BIOMETRIC_STRONG or
                            BiometricManager.Authenticators.BIOMETRIC_WEAK
                    )
                }
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.P ->
                Intent("android.settings.FINGERPRINT_ENROLL")
            else -> Intent(Settings.ACTION_SECURITY_SETTINGS)
        }
        try {
            startActivity(intent)
        } catch (e: Exception) {
            // Some OEMs don't handle the specific action — fall back to the
            // general security settings, which always exists.
            startActivity(Intent(Settings.ACTION_SECURITY_SETTINGS))
        }
    }

    /** HCE works only on a device with the HCE feature AND NFC turned on. */
    private fun isHceSupported(): Boolean {
        if (!packageManager.hasSystemFeature("android.hardware.nfc.hce")) return false
        val adapter = NfcAdapter.getDefaultAdapter(this) ?: return false
        return adapter.isEnabled
    }
    /// The system's record of how this process last died.
    ///
    /// Returns a list of maps rather than a typed object so the Dart side can
    /// ship them straight to the log pipeline without a codec on either end.
    ///
    /// The ANR TRACE is the valuable part and it is a large blob — the main
    /// thread's stack at the moment the system gave up on it, which is the
    /// one thing that says WHERE the app was stuck. It is truncated here
    /// rather than on the Dart side so an oversized trace never crosses the
    /// channel at all; the first frames are the ones that matter.
    private fun recentExits(): List<Map<String, Any?>> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return emptyList()
        return try {
            val am = getSystemService(ActivityManager::class.java)
                ?: return emptyList()
            am.getHistoricalProcessExitReasons(packageName, 0, MAX_EXITS)
                .map { info ->
                    mapOf(
                        "reason" to reasonName(info.reason),
                        "reasonCode" to info.reason,
                        "description" to info.description,
                        "timestamp" to info.timestamp,
                        "importance" to info.importance,
                        "pss" to info.pss,
                        "rss" to info.rss,
                        // Only an ANR carries a trace, and reading the stream
                        // for other reasons would be wasted I/O on every cold
                        // start.
                        "trace" to if (info.reason == ApplicationExitInfo.REASON_ANR) {
                            readTrace(info)
                        } else {
                            null
                        }
                    )
                }
        } catch (t: Throwable) {
            // Diagnostics must never be the reason a launch fails. An
            // unreadable exit list is less bad than an app that will not
            // start because it could not find out why it stopped.
            emptyList()
        }
    }

    private fun readTrace(info: ApplicationExitInfo): String? = try {
        info.traceInputStream?.use { stream ->
            val text = stream.bufferedReader().readText()
            if (text.length > MAX_TRACE_CHARS) {
                text.substring(0, MAX_TRACE_CHARS) + "\n…truncated"
            } else {
                text
            }
        }
    } catch (t: Throwable) {
        null
    }

    private fun reasonName(code: Int): String = when (code) {
        ApplicationExitInfo.REASON_ANR -> "anr"
        ApplicationExitInfo.REASON_CRASH -> "crash"
        ApplicationExitInfo.REASON_CRASH_NATIVE -> "crash_native"
        ApplicationExitInfo.REASON_LOW_MEMORY -> "low_memory"
        ApplicationExitInfo.REASON_EXCESSIVE_RESOURCE_USAGE -> "excessive_resource_usage"
        ApplicationExitInfo.REASON_SIGNALED -> "signaled"
        ApplicationExitInfo.REASON_USER_REQUESTED -> "user_requested"
        ApplicationExitInfo.REASON_USER_STOPPED -> "user_stopped"
        ApplicationExitInfo.REASON_DEPENDENCY_DIED -> "dependency_died"
        ApplicationExitInfo.REASON_PERMISSION_CHANGE -> "permission_change"
        ApplicationExitInfo.REASON_INITIALIZATION_FAILURE -> "initialization_failure"
        ApplicationExitInfo.REASON_EXIT_SELF -> "exit_self"
        else -> "other_$code"
    }

    private companion object {
        /// Android keeps up to 16; five is plenty to notice a pattern without
        /// re-uploading the same history on every launch.
        const val MAX_EXITS = 5

        /// Enough for the main thread's stack, which is the part that says
        /// where it was stuck.
        ///
        /// MATCHED TO RemoteLogSink._maxDiagnosticChars. The sink caps every
        /// field, so shipping more than it accepts spends the user's data
        /// on bytes that are discarded on arrival — and the field still
        /// LOOKS complete in Loki, which is the worst version of missing.
        /// Change both or neither.
        const val MAX_TRACE_CHARS = 12000
    }

}
