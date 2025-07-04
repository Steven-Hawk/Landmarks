//
//  ContentView.swift
//  Landmarks
//
//  Created by Steven Hawk on 7/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
