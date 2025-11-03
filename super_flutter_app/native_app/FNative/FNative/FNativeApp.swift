//
//  FNativeApp.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/1.
//

import Foundation
import SwiftUI
import Flutter
import FlutterPluginRegistrant

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
