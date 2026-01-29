package com.pkb.flutter_security_rasp

import android.content.Context
import com.pkb.flutter_security_rasp.sec.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.pkb.flutter_security_rasp.sec.*
import com.pkb.flutter_security_rasp.sec.DevOptionsCheck


class FlutterSecurityRaspPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var c: Context
    private lateinit var ch: MethodChannel

    override fun onAttachedToEngine(b: FlutterPlugin.FlutterPluginBinding) {
        c = b.applicationContext
        ch = MethodChannel(b.binaryMessenger, "sys.core.bridge.a9")
        ch.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "x1") {
            val hash = call.argument<String>("k") ?: ""
            result.success(mapOf(
                "a" to HookCheck.detect(),
                "b" to RootCheck.detect(),
                "c" to DebugCheck.detect(),
                "d" to EmuCheck.detect(),
                "e" to TamperCheck.detect(c, hash),
                "f" to DevOptionsCheck.detect(c)
            ))
        }
    }

    override fun onDetachedFromEngine(b: FlutterPlugin.FlutterPluginBinding) {
        ch.setMethodCallHandler(null)
    }
}
