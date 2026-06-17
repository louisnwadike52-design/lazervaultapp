package com.lazervault.app

import android.nfc.cardemulation.HostApduService
import android.os.Bundle
import java.io.ByteArrayOutputStream

/**
 * NFC Forum Type 4 Tag emulation via Host Card Emulation (HCE).
 *
 * This is what makes phone-to-phone contactless payments actually work on
 * Android: when a LazerVault receiver opens the "Receive Payment" screen we
 * load the payment session's NDEF message into [ndefMessage] (via the
 * `com.lazervault.app/hce` MethodChannel in MainActivity). Any NFC reader —
 * an Android payer running NfcManager, OR an iPhone payer using CoreNFC —
 * that taps the receiver's phone reads this emulated tag and gets the session
 * payload, exactly as if it had tapped a physical NFC sticker.
 *
 * Apple does NOT allow HCE for third-party apps, so this is Android-only; an
 * iOS *receiver* falls back to Session ID mode (handled in Flutter). iOS can
 * still *read* this emulated tag as a payer.
 *
 * The APDU exchange follows the NFC Forum Type 4 Tag Operation spec:
 *   1. SELECT NDEF application (AID D2760000850101)
 *   2. SELECT Capability Container (CC) file (E103) → READ_BINARY
 *   3. SELECT NDEF file (E104) → READ_BINARY ( [NLEN hi][NLEN lo][NDEF msg] )
 */
class LazerVaultHostApduService : HostApduService() {

    companion object {
        /**
         * The NDEF message currently being broadcast. `null`/empty => the tag
         * responds as empty (NLEN = 0). Set when a payment session goes live;
         * cleared when the receiver screen closes. @Volatile because it's read
         * on the NFC binder thread and written from the main thread.
         */
        @Volatile
        var ndefMessage: ByteArray? = null

        // Status words.
        private val SW_OK = byteArrayOf(0x90.toByte(), 0x00.toByte())
        private val SW_FILE_NOT_FOUND = byteArrayOf(0x6A.toByte(), 0x82.toByte())
        private val SW_INS_NOT_SUPPORTED = byteArrayOf(0x6D.toByte(), 0x00.toByte())

        // SELECT by name of the NDEF Type 4 application:
        //   00 A4 04 00 07  D2 76 00 00 85 01 01  00
        private val SELECT_NDEF_APP = byteArrayOf(
            0x00, 0xA4.toByte(), 0x04, 0x00, 0x07,
            0xD2.toByte(), 0x76, 0x00, 0x00, 0x85.toByte(), 0x01, 0x01, 0x00
        )

        private val CC_FILE_ID = byteArrayOf(0xE1.toByte(), 0x03)
        private val NDEF_FILE_ID = byteArrayOf(0xE1.toByte(), 0x04)

        // Capability Container: NDEF readable, write disabled, max NDEF 0x7FFF.
        private val CC_FILE = byteArrayOf(
            0x00, 0x0F,                 // CCLEN = 15
            0x20,                       // mapping version 2.0
            0x00, 0x3B,                 // MLe  = 59  (max bytes in an R-APDU)
            0x00, 0x34,                 // MLc  = 52  (max bytes in a C-APDU)
            0x04,                       // NDEF File Control TLV — T
            0x06,                       // NDEF File Control TLV — L
            0xE1.toByte(), 0x04,        // NDEF file id
            0x7F, 0xFF.toByte(),        // max NDEF file size
            0x00,                       // read access granted
            0xFF.toByte()              // write access denied
        )
    }

    // Which file the reader last SELECTed (CC or NDEF), so the next READ_BINARY
    // knows what to return.
    private var selectedFile: ByteArray? = null

    override fun processCommandApdu(commandApdu: ByteArray?, extras: Bundle?): ByteArray {
        if (commandApdu == null || commandApdu.size < 2) return SW_INS_NOT_SUPPORTED

        // 1. SELECT NDEF application.
        if (commandApdu.size >= SELECT_NDEF_APP.size &&
            commandApdu.copyOfRange(0, SELECT_NDEF_APP.size).contentEquals(SELECT_NDEF_APP)
        ) {
            selectedFile = null
            return SW_OK
        }

        val cla = commandApdu[0]
        val ins = commandApdu[1]

        // 2. SELECT file by id:  00 A4 00 0C 02 <fileId hi> <fileId lo>
        if (cla == 0x00.toByte() && ins == 0xA4.toByte() && commandApdu.size >= 7) {
            val fileId = commandApdu.copyOfRange(5, 7)
            selectedFile = when {
                fileId.contentEquals(CC_FILE_ID) -> CC_FILE
                fileId.contentEquals(NDEF_FILE_ID) -> buildNdefFile()
                else -> null
            }
            return if (selectedFile != null) SW_OK else SW_FILE_NOT_FOUND
        }

        // 3. READ_BINARY:  00 B0 <offset hi> <offset lo> <Le>
        if (cla == 0x00.toByte() && ins == 0xB0.toByte() && commandApdu.size >= 5) {
            val file = selectedFile ?: return SW_FILE_NOT_FOUND
            val offset = ((commandApdu[2].toInt() and 0xFF) shl 8) or (commandApdu[3].toInt() and 0xFF)
            var le = commandApdu[4].toInt() and 0xFF
            if (le == 0) le = 256
            if (offset > file.size) return SW_FILE_NOT_FOUND
            val end = minOf(offset + le, file.size)
            return file.copyOfRange(offset, end) + SW_OK
        }

        return SW_INS_NOT_SUPPORTED
    }

    /** NDEF file = 2-byte big-endian NLEN followed by the NDEF message bytes. */
    private fun buildNdefFile(): ByteArray {
        val msg = ndefMessage ?: ByteArray(0)
        val nlen = msg.size
        return ByteArrayOutputStream(nlen + 2).apply {
            write((nlen shr 8) and 0xFF)
            write(nlen and 0xFF)
            write(msg)
        }.toByteArray()
    }

    override fun onDeactivated(reason: Int) {
        selectedFile = null
    }
}
