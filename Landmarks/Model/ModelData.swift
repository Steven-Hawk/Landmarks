//
//  ModelData.swift
//  Landmarks
//
//  Created by Steven Hawk on 7/3/25.
//

import Foundation

@Observable
class ModelData {
    var landmarks: [Landmark] = []

    init() {
        landmarks = load("landmarkData.json")
        Task {
            await fetchRemoteLandmarks()
        }
    }

    @MainActor
    private func fetchRemoteLandmarks() async {
        do {
            let remote = try await NPSService().fetchLandmarks()
            if !remote.isEmpty {
                landmarks = remote
            }
        } catch {
            // If the network call fails, fall back to bundled data.
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
