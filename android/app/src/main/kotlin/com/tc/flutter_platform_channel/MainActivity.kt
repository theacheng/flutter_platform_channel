package com.tc.flutter_platform_channel

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity : FlutterActivity() {
    private val batteryChannel = "battery"
    private val volumeChannel = "volume"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, batteryChannel).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, volumeChannel).setMethodCallHandler {
            call, result ->
            val audioManager: AudioManager = getSystemService(AUDIO_SERVICE) as AudioManager
            if (call.method == "setVolumeLevel") {
                var level = call.argument<Int>("level");
                if (level != null) {
                    audioManager.setMediaVolume(level);
                }
            }

            if(call.method == "getMaxVolume"){
                result.success(audioManager.mediaMaxVolume);
            }

            if(call.method == "getCurrentVolume"){
                result.success(audioManager.currentMediaVolume)
            }
        }

    }

    private fun getBatteryLevel(): Int {
        return if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            this.intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / this.intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
    }
}

fun AudioManager.setMediaVolume(volumeIndex:Int) {
    // Set media volume level
    this.setStreamVolume(
            AudioManager.STREAM_MUSIC, // Stream type
            volumeIndex, // Volume index
            AudioManager.FLAG_SHOW_UI// Flags
    )
}

val AudioManager.currentMediaVolume:Int
    get() = this.getStreamVolume(AudioManager.STREAM_MUSIC);

val AudioManager.mediaMaxVolume:Int
    get() = this.getStreamMaxVolume(AudioManager.STREAM_MUSIC)

