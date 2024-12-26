import 'tap_to_pay_plugin_platform_interface.dart';

class TapToPayPlugin {
  Future<String?> getPlatformVersion() {
    return TapToPayPluginPlatform.instance.getPlatformVersion();
  }

  Future<void> payment() {
    return TapToPayPluginPlatform.instance.payment();
  }
}
