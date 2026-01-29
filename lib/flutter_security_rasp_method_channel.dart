import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_security_rasp_platform_interface.dart';

/// An implementation of [FlutterSecurityRaspPlatform] that uses method channels.
class MethodChannelFlutterSecurityRasp extends FlutterSecurityRaspPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_security_rasp');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
