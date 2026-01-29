package com.pkb.flutter_security_rasp.sec

import android.content.Context
import android.content.pm.ApplicationInfo
import android.provider.Settings

object DevOptionsCheck {

    fun detect(context: Context): Boolean {
        return isDeveloperOptions(context)
                || isUsbDebugging(context)
                || isAppDebuggable(context)
    }

    // Developer options เปิด
    private fun isDeveloperOptions(context: Context): Boolean {
        return Settings.Global.getInt(
            context.contentResolver,
            Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
            0
        ) == 1
    }

    // USB debugging เปิด
    private fun isUsbDebugging(context: Context): Boolean {
        return Settings.Global.getInt(
            context.contentResolver,
            Settings.Global.ADB_ENABLED,
            0
        ) == 1
    }

    // แอปถูก build แบบ debuggable (Run จาก Studio)
    private fun isAppDebuggable(context: Context): Boolean {
        return (context.applicationInfo.flags and
                ApplicationInfo.FLAG_DEBUGGABLE) != 0
    }
}
