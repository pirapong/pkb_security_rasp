import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pkb_security_rasp/pkb_security_rasp.dart';

const androidHash = "PUT_ANDROID_SHA256_HERE";
const iosHash = "PUT_IOS_SHA256_HERE";

void main() {
  runApp(const RaspTestApp());
}

class RaspTestApp extends StatefulWidget {
  const RaspTestApp({super.key});

  @override
  State<RaspTestApp> createState() => _RaspTestAppState();
}

class _RaspTestAppState extends State<RaspTestApp> {
  RaspStatus? status;

  @override
  void initState() {
    super.initState();
    runCheck();
  }

  Future<void> runCheck() async {
    final hash = Platform.isAndroid ? androidHash : iosHash;
    final s = await FlutterSecurityRasp.check(hash);
    setState(() => status = s);
  }

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (status!.compromised) {
      return MaterialApp(
        home: BlockedPage(status: status!, onRetry: runCheck),
      );
    }

    return MaterialApp(
      home: HomePage(status: status!, onRetry: runCheck),
    );
  }
}

class HomePage extends StatelessWidget {
  final RaspStatus status;
  final VoidCallback onRetry;

  const HomePage({
    super.key,
    required this.status,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RASP Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item("Hooked", status.h),
            item("Root/JB", status.r),
            item("Debugged (Debugger)", status.d),
            item("Dev Options / USB Debug", status.f),
            item("Emulator", status.e),
            item("Tampered", status.t),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Re-check"),
            )
          ],
        ),
      ),
    );
  }

  Widget item(String title, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        "$title : $value",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class BlockedPage extends StatelessWidget {
  final RaspStatus status;
  final VoidCallback onRetry;

  const BlockedPage({
    super.key,
    required this.status,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "DEVICE COMPROMISED",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 20),
            Text(
              "Hooked: ${status.h}\n"
                  "Root/JB: ${status.r}\n"
                  "Debugged: ${status.d}\n"
                  "Dev Options: ${status.f}\n"
                  "Emulator: ${status.e}\n"
                  "Tampered: ${status.t}",
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Re-check"),
            )
          ],
        ),
      ),
    );
  }
}
