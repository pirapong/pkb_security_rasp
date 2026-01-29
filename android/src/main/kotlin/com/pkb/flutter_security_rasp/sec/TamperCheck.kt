package com.pkb.flutter_security_rasp.sec

import android.content.Context
import java.io.File
import java.security.MessageDigest

object TamperCheck {

    fun detect(context: Context, expected: String): Boolean {
        return try {
            val apk = context.packageCodePath
            val hash = sha256(File(apk).readBytes())
            hash != expected
        } catch (e: Exception) {
            true
        }
    }

    private fun sha256(bytes: ByteArray): String {
        val md = MessageDigest.getInstance("SHA-256")
        return md.digest(bytes).joinToString("") { "%02x".format(it) }
    }
}
