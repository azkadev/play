//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <media_kit_libs_windows_audio/media_kit_libs_windows_audio_plugin_c_api.h>
#include <media_kit_libs_windows_video/media_kit_libs_windows_video_plugin_c_api.h>
#include <media_kit_video/media_kit_video_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  MediaKitLibsWindowsAudioPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MediaKitLibsWindowsAudioPluginCApi"));
  MediaKitLibsWindowsVideoPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MediaKitLibsWindowsVideoPluginCApi"));
  MediaKitVideoPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MediaKitVideoPluginCApi"));
}
