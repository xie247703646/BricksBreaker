package com.godot.game

import android.app.Application
import com.zh.pocket.PocketSdk

class App:Application() {
    override fun onCreate() {
        super.onCreate()
        PocketSdk.initSDK(this, "taptap", "12328")
    }
}