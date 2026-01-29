import Flutter
import UIKit
import MachO
import Darwin
import CommonCrypto

public class FlutterSecurityRaspPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let ch = FlutterMethodChannel(
      name: "sys.core.bridge.a9",
      binaryMessenger: registrar.messenger()
    )
    registrar.addMethodCallDelegate(FlutterSecurityRaspPlugin(), channel: ch)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "x1",
       let args = call.arguments as? [String: Any],
       let hash = args["k"] as? String {

      result([
        "a": isHooked(),
        "b": isJailbroken(),
        "c": isDebugged(),        // Debugger attach
        "d": false,
        "e": isTampered(hash),
        "f": isDeveloperMode()   // ⭐ Developer Mode แยกออกมา
      ])
    }
  }

  // MARK: - Hook Detection

  private func isHooked() -> Bool {
    let keys = ["frida", "gadget", "substrate", "cycript"]

    for i in 0..<_dyld_image_count() {
      if let name = _dyld_get_image_name(i) {
        let s = String(cString: name).lowercased()
        for k in keys {
          if s.contains(k) { return true }
        }
      }
    }
    return false
  }

  // MARK: - Jailbreak Detection

  private func isJailbroken() -> Bool {
    let paths = [
      "/Applications/Cydia.app",
      "/bin/bash",
      "/etc/apt",
      "/usr/sbin/sshd"
    ]

    for p in paths {
      if FileManager.default.fileExists(atPath: p) {
        return true
      }
    }
    return false
  }

  // MARK: - Debugger Detection (LLDB / ptrace)

  private func isDebugged() -> Bool {

    var info = kinfo_proc()
    var size = MemoryLayout<kinfo_proc>.stride
    var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    sysctl(&mib, 4, &info, &size, nil, 0)

    if (info.kp_proc.p_flag & P_TRACED) != 0 {
      return true
    }

    let env = ProcessInfo.processInfo.environment
    if env["__XCODE_BUILT_PRODUCTS_DIR_PATHS"] != nil { return true }
    if env["OS_ACTIVITY_DT_MODE"] != nil { return true }

    let handle = dlopen(nil, RTLD_NOW)
    if dlsym(handle, "ptrace") != nil {
      return true
    }

    return false
  }

  // MARK: - Developer Mode Detection ⭐

  private func isDeveloperMode() -> Bool {
    #if DEBUG
    return true
    #else
    if Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt" {
      return true
    }
    #endif
    return false
  }

  // MARK: - Tamper Detection

  private func isTampered(_ expected: String) -> Bool {
    guard let path = Bundle.main.executablePath else { return true }

    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      return sha256(data) != expected
    } catch {
      return true
    }
  }

  private func sha256(_ data: Data) -> String {
    var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    data.withUnsafeBytes {
      _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
    }
    return hash.map { String(format: "%02x", $0) }.joined()
  }
}
