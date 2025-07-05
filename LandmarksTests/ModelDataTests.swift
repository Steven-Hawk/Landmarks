import XCTest
import Foundation
@testable import Landmarks

final class ModelDataTests: XCTestCase {
    func testLandmarksLoaded() {
        let model = ModelData()
        XCTAssertFalse(model.landmarks.isEmpty)
    }

    func testNPSServiceRequiresAPIKey() async {
        unsetenv("NPS_API_KEY")
        do {
            _ = try await NPSService().fetchLandmarks()
            XCTFail("Expected missing key error")
        } catch let error as NPSService.NPSError {
            XCTAssertEqual(error, .missingAPIKey)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
