//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Steven Hawk on 7/3/25.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
