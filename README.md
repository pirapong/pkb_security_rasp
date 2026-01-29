# flutter_security_rasp

RASP (Runtime Application Self-Protection) plugin for Flutter.

Detects runtime threats such as Frida hooking, Root/Jailbreak, Debugger attach, Developer options, Emulator usage, and App tampering (hash verification) on both **Android** and **iOS**.

This plugin is designed for **banking, fintech, enterprise, and high-security Flutter applications**.

---

## ✨ Features

| Check | Android | iOS |
|---|---|---|
| Frida / Substrate / Hook detection | ✅ | ✅ |
| Root / Jailbreak detection | ✅ | ✅ |
| Debugger attached detection | ✅ | ✅ |
| Developer options / USB debug | ✅ | ✅ |
| Emulator detection | ✅ | ❌ |
| App tamper detection (SHA256) | ✅ | ✅ |

---

## 📦 Installation

```yaml
dependencies:
  pkb_security_rasp: ^1.0.0
