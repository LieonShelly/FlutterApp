//
//  FNativeApp.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/1.
//

import Foundation
import SwiftUI
import Flutter


@Observable
class FlutterDependencies {
    let flutterEngine = FlutterEngine(name: "my flutter engine")
    init() {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run()
        // Connects plugins with iOS platform code to this app.
        
    }
}


@main
struct FNativeApp: App {
    @State var flutterDependencies = FlutterDependencies()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(flutterDependencies)
        }
    }
}
