package com.pkb.flutter_security_rasp.sec

import java.io.File

object RootCheck {
    fun detect(): Boolean {
        val paths = arrayOf("/system/bin/su", "/system/xbin/su", "/sbin/su")
        return paths.any { File(it).exists() }
    }
}
