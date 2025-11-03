//
//  FlutterDependencies.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/3.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant
import Foundation
import Combine

class FlutterDependencies: ObservableObject {
    
    let flutterEngine: FlutterEngine
    
    init(flutterEngine: FlutterEngine) {
        self.flutterEngine = flutterEngine
        flutterEngine.run(withEntrypoint: nil, initialRoute: "/home")
        GeneratedPluginRegistrant.register(with: flutterEngine)
    }
    
}
