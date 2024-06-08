import XCTest

final class UITests: XCTestCase {    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results
    }
    
    // This measures how long it takes to launch your application
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13, tvOS 13, watchOS 7, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
