import Foundation
import CoreLocation

struct NPSService {
    enum NPSError: Error {
        case missingAPIKey
    }
    struct APIResponse: Decodable {
        let data: [NPSPark]
    }
    struct NPSPark: Decodable {
        let id: String
        let fullName: String
        let description: String
        let states: String
        let latLong: String?
    }

    func fetchLandmarks() async throws -> [Landmark] {
        guard let apiKey = ProcessInfo.processInfo.environment["NPS_API_KEY"],
              !apiKey.isEmpty else {
            throw NPSError.missingAPIKey
        }
        var components = URLComponents(string: "https://developer.nps.gov/api/v1/parks")!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "50"),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let response = try JSONDecoder().decode(APIResponse.self, from: data)
        return response.data.compactMap { park in
            guard let coord = parseLatLong(park.latLong ?? "") else { return nil }
            return Landmark(
                id: park.id.hashValue,
                name: park.fullName,
                park: park.fullName,
                state: park.states,
                description: park.description,
                isFavorite: false,
                imageName: "turtlerock",
                coordinates: Landmark.Coordinates(latitude: coord.latitude, longitude: coord.longitude)
            )
        }
    }

    private func parseLatLong(_ string: String) -> CLLocationCoordinate2D? {
        let parts = string.split(separator: ",")
        guard parts.count == 2 else { return nil }
        let latPart = parts[0].trimmingCharacters(in: .whitespaces)
        let longPart = parts[1].trimmingCharacters(in: .whitespaces)
        guard let latValue = Double(latPart.replacingOccurrences(of: "lat:", with: "")),
              let longValue = Double(longPart.replacingOccurrences(of: "long:", with: "")) else { return nil }
        return CLLocationCoordinate2D(latitude: latValue, longitude: longValue)
    }
}
