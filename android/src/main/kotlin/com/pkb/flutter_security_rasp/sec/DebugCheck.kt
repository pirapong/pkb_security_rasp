package com.pkb.flutter_security_rasp.sec

import android.os.Debug
import java.io.File

object DebugCheck {

    fun detect(): Boolean {
        return Debug.isDebuggerConnected()
                || isTracerPid()
                || isBeingDebuggedByArt()
    }

    private fun isTracerPid(): Boolean {
        return try {
            val status = File("/proc/self/status").readText()
            val tracer = Regex("TracerPid:\\s*(\\d+)").find(status)
            tracer?.groupValues?.get(1)?.toInt() ?: 0 > 0
        } catch (e: Exception) {
            false
        }
    }

    // Android Studio ใหม่ / ART debugger
    private fun isBeingDebuggedByArt(): Boolean {
        return try {
            val status = File("/proc/self/status").readText()
            status.contains("State:\tt (tracing stop)")
        } catch (e: Exception) {
            false
        }
    }
}
