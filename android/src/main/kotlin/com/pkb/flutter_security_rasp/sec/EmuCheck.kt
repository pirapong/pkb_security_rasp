package com.pkb.flutter_security_rasp.sec

import android.os.Build

object EmuCheck {
    fun detect(): Boolean {
        return Build.FINGERPRINT.contains("generic")
                || Build.MODEL.contains("Emulator")
                || Build.MANUFACTURER.contains("Genymotion")
    }
}
