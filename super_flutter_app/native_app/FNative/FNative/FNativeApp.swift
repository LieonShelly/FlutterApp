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
    @StateObject var flutterDependencies = FlutterDependencies(flutterEngine: .init(name: "engine"))

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(flutterDependencies)
        }
    }
}
