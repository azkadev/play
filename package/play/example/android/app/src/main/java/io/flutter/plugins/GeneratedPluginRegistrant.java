package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new com.mr.flutter.plugin.filepicker.FilePickerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin file_picker, com.mr.flutter.plugin.filepicker.FilePickerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.alexmercerind.media_kit_libs_android_video.MediaKitLibsAndroidVideoPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin media_kit_libs_android_video, com.alexmercerind.media_kit_libs_android_video.MediaKitLibsAndroidVideoPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.alexmercerind.media_kit_video.MediaKitVideoPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin media_kit_video, com.alexmercerind.media_kit_video.MediaKitVideoPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.aaassseee.screen_brightness_android.ScreenBrightnessAndroidPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin screen_brightness_android, com.aaassseee.screen_brightness_android.ScreenBrightnessAndroidPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.videoplayer.VideoPlayerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin video_player_android, io.flutter.plugins.videoplayer.VideoPlayerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.kurenai7968.volume_controller.VolumeControllerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin volume_controller, com.kurenai7968.volume_controller.VolumeControllerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new creativemaybeno.wakelock.WakelockPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin wakelock, creativemaybeno.wakelock.WakelockPlugin", e);
    }
  }
}
