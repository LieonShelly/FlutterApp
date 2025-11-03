//
//  ContentView.swift
//  FNative
//
//  Created by Renjun Li on 2025/11/1.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
             NavigationLink("My Flutter Feature") {
               FlutterViewControllerRepresentable()
             }
           }
    }
}

#Preview {
    ContentView()
}
