import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tap_to_pay_plugin_method_channel.dart';

abstract class TapToPayPluginPlatform extends PlatformInterface {
  /// Constructs a TapToPayPluginPlatform.
  TapToPayPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TapToPayPluginPlatform _instance = MethodChannelTapToPayPlugin();

  /// The default instance of [TapToPayPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTapToPayPlugin].
  static TapToPayPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TapToPayPluginPlatform] when
  /// they register themselves.
  static set instance(TapToPayPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> payment() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
