package com.pkb.flutter_security_rasp.sec
import java.io.File

object HookCheck {
    fun detect(): Boolean {
        return try {
            val maps = File("/proc/self/maps").readText()
            maps.contains("frida") || maps.contains("xposed")
        } catch (e: Exception) {
            false
        }
    }
}