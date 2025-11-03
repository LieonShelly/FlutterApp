//
//  FlutterViewControllerRepresentable.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/3.
//
import SwiftUI
import Flutter
import FlutterPluginRegistrant

struct FlutterViewControllerRepresentable: UIViewControllerRepresentable {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return FlutterViewController(
            engine: flutterDependencies.flutterEngine,
            nibName: nil,
            bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
