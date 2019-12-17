import XCTest
import Spatial

class SpatialTests: XCTestCase {
   override func setUp() {
      super.setUp()
   }
   override func tearDown() {
      super.tearDown()
   }
   func testExample() {
      XCTAssertEqual(Align.alignmentPoint(objectSize: .init(width: 200, height: 200), canvasSize: .init(width: 400, height: 300), canvasAlign: .centerCenter, objectAlign: .topLeft), .init(x: 200.0, y: 150.0)) // Output: centers a circle within 400x300 rectangle
      XCTAssertEqual(Align.alignmentPoint(objectSize: .init(width: 200, height: 200), canvasSize: .init(width: 400, height: 300), canvasAlign: .centerRight, objectAlign: .centerRight), .init(x: 200.0, y: 50.0)) // Output: aligns the circle to the y axis center and  to the right border of the rectangle but withinn the rectange
   }
   func testPerformanceExample() {
      self.measure { }
   }
}
