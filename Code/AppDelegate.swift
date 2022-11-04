//
// AppDelegate
// MacDial
//
// Created by Alex Babaev on 28 January 2022.
//
// Based on Andreas Karlsson sources
// https://github.com/andreasjhkarlsson/mac-dial
//
// License: MIT
//

import AppKit

let logsEnabled: Bool = true

func log(_ message: @autoclosure () -> String) {
    guard logsEnabled else { return }

    print(message())
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet private var controller: AppController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        checkPermissionsAndRequestIfNeeded()
    }

    private func checkPermissionsAndRequestIfNeeded() {
        func checkPermissionsAndRepeat() {
            let result = AXIsProcessTrusted()
            if !result {
                log("Still no permission...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    checkPermissionsAndRepeat()
                }
            }
        }

        if !AXIsProcessTrusted() {
            let options: NSDictionary = [ kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true ]
            _ = AXIsProcessTrustedWithOptions(options)
            checkPermissionsAndRepeat()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        controller.terminate()
    }
}
