//
//  ContentView.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/1.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    
    var body: some View {
        NavigationStack {
             NavigationLink("home") {
               FlutterViewControllerRepresentable(route: "/home")
             }
            
            NavigationLink("user") {
              FlutterViewControllerRepresentable(route: "/user")
            }
           }
    }
}

#Preview {
    ContentView()
}
