package com.pkb.flutter_security_rasp.sec

import android.content.Context
import java.io.File
import java.security.MessageDigest

object TamperCheck {

    fun detect(context: Context, expected: String): Boolean {
        return try {
            val apk = context.packageCodePath
            val hash = sha256(File(apk))   // ✅ อ่านแบบ stream
            hash != expected
        } catch (e: Exception) {
            true
        }
    }

    private fun sha256(file: File): String {
        val digest = MessageDigest.getInstance("SHA-256")

        file.inputStream().use { fis ->
            val buffer = ByteArray(8192)
            var read: Int
            while (fis.read(buffer).also { read = it } != -1) {
                digest.update(buffer, 0, read)
            }
        }

        return digest.digest().joinToString("") { "%02x".format(it) }
    }
}
