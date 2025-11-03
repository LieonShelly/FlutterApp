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


@Observable
class FlutterDependencies {
    let flutterEngine = FlutterEngine(name: "my flutter engine")
    init() {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run()
        // Connects plugins with iOS platform code to this app.
        GeneratedPluginRegistrant.register(with: self.flutterEngine);

    }
}

struct FlutterViewControllerRepresentable: UIViewControllerRepresentable {
    // Flutter dependencies are passed in through the view environment.
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return FlutterViewController(
            engine: flutterDependencies.flutterEngine,
            nibName: nil,
            bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
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
