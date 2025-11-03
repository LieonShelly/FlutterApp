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
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    private let route: String
    
    init(route: String) {
        self.route = route
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return FlutterViewController(
            engine: flutterDependencies.flutterEngine,
            nibName: nil,
            bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let uiViewController = uiViewController as? FlutterViewController else { return }
        uiViewController.pushRoute(route)
    }
}
