import 'package:flutter_test/flutter_test.dart';
import 'package:tap_to_pay_plugin/tap_to_pay_plugin.dart';
import 'package:tap_to_pay_plugin/tap_to_pay_plugin_platform_interface.dart';
import 'package:tap_to_pay_plugin/tap_to_pay_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTapToPayPluginPlatform
    with MockPlatformInterfaceMixin
    implements TapToPayPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TapToPayPluginPlatform initialPlatform = TapToPayPluginPlatform.instance;

  test('$MethodChannelTapToPayPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTapToPayPlugin>());
  });

  test('getPlatformVersion', () async {
    TapToPayPlugin tapToPayPlugin = TapToPayPlugin();
    MockTapToPayPluginPlatform fakePlatform = MockTapToPayPluginPlatform();
    TapToPayPluginPlatform.instance = fakePlatform;

    expect(await tapToPayPlugin.getPlatformVersion(), '42');
  });
}
