import XCTest
@testable import Landmarks

final class ModelDataTests: XCTestCase {
    func testLandmarksLoaded() {
        let model = ModelData()
        XCTAssertFalse(model.landmarks.isEmpty)
    }
}
