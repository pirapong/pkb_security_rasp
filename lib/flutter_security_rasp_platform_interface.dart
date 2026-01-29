import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_security_rasp_method_channel.dart';

abstract class FlutterSecurityRaspPlatform extends PlatformInterface {
  /// Constructs a FlutterSecurityRaspPlatform.
  FlutterSecurityRaspPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSecurityRaspPlatform _instance = MethodChannelFlutterSecurityRasp();

  /// The default instance of [FlutterSecurityRaspPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSecurityRasp].
  static FlutterSecurityRaspPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSecurityRaspPlatform] when
  /// they register themselves.
  static set instance(FlutterSecurityRaspPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
