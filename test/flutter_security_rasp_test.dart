// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_security_rasp/flutter_security_rasp.dart';
// import 'package:flutter_security_rasp/flutter_security_rasp_platform_interface.dart';
// import 'package:flutter_security_rasp/flutter_security_rasp_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockFlutterSecurityRaspPlatform
//     with MockPlatformInterfaceMixin
//     implements FlutterSecurityRaspPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final FlutterSecurityRaspPlatform initialPlatform = FlutterSecurityRaspPlatform.instance;
//
//   test('$MethodChannelFlutterSecurityRasp is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFlutterSecurityRasp>());
//   });
//
//   test('getPlatformVersion', () async {
//     FlutterSecurityRasp flutterSecurityRaspPlugin = FlutterSecurityRasp();
//     MockFlutterSecurityRaspPlatform fakePlatform = MockFlutterSecurityRaspPlatform();
//     FlutterSecurityRaspPlatform.instance = fakePlatform;
//
//     expect(await flutterSecurityRaspPlugin.getPlatformVersion(), '42');
//   });
// }
