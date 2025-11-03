//
//  FlutterDependencies.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/3.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant


@Observable
class FlutterDependencies {
    let flutterEngine = FlutterEngine(name: "my flutter engine")
    
    init() {
        flutterEngine.run(withEntrypoint: nil, initialRoute: "/home")
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
    }
}
