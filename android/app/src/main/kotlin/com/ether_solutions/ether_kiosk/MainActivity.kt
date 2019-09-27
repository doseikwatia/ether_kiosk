package com.ether_solutions.ether_kiosk

import android.os.Bundle
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    FacebookSdk.sdkInitialize(applicationContext)
    AppEventsLogger.activateApp(application)
    GeneratedPluginRegistrant.registerWith(this)
  }
}
