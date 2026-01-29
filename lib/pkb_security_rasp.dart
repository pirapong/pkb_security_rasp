import 'package:flutter/services.dart';

class RaspStatus {
  final bool h;
  final bool r;
  final bool d;
  final bool e;
  final bool t;
  final bool f;

  RaspStatus(
      this.h,
      this.r,
      this.d,
      this.e,
      this.t,
      this.f,
      );

  bool get compromised => h || r || d || e || t || f;

  factory RaspStatus.fromMap(Map<dynamic, dynamic> m) {
    return RaspStatus(
      m['a'] ?? false,
      m['b'] ?? false,
      m['c'] ?? false,
      m['d'] ?? false,
      m['e'] ?? false,
      m['f'] ?? false,
    );
  }
}

class FlutterSecurityRasp {
  static const _c = MethodChannel('sys.core.bridge.a9');

  static Future<RaspStatus> check(String hash) async {
    final r = await _c.invokeMethod('x1', {"k": hash});
    return RaspStatus.fromMap(r);
  }
}
