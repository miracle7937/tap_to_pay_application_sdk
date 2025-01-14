import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_to_pay_plugin/tap_to_pay_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTapToPayPlugin platform = MethodChannelTapToPayPlugin();
  const MethodChannel channel = MethodChannel('tap_to_pay_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
