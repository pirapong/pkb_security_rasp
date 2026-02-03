## 1.0.0
- Initial release
- Frida / Substrate hook detection (Android & iOS)
- Root / Jailbreak detection
- Debugger detection (ART / LLDB)
- Developer options / USB debug detection
- Emulator detection (Android)
- SHA256 app tamper detection
- Example app with RASP dashboard

## 1.0.1
- Fixed OutOfMemoryError during Android SHA256 tamper detection
- Replaced unsafe File.readBytes() with stream-based hashing (8KB buffer)
- Fixed Android app termination caused by Navigator re-entrant navigation in NavigatorObserver
- Fixed crash from using different navigatorKey between MaterialApp and RASP observer
- Fixed navigation conflict between RASP block screen and secure snapshot mask
- Improved stability on emulator, debug builds, release builds, and low-RAM devices
- Removed deprecated sha256(bytes: ByteArray) and all APK readBytes() usage