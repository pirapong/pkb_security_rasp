import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkb_security_rasp/flutter_security_rasp_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterSecurityRasp platform = MethodChannelFlutterSecurityRasp();
  const MethodChannel channel = MethodChannel('flutter_security_rasp');

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
