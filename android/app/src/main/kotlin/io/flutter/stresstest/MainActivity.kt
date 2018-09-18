package io.flutter.stresstest

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.stresstest.list.NativeListViewActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                METHOD_NATIVE_LIST -> {
                    startActivity(Intent(this, NativeListViewActivity::class.java))
                    result.success("ok")
                }
            }
        }
    }

    companion object {
        private const val CHANNEL = "io.flutter/stresstest"
        private const val METHOD_NATIVE_LIST = "nativeList"
    }
}
