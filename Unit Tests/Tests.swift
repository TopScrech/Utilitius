import XCTest

final class Tests: XCTestCase {
    override func setUpWithError() throws {
        print("\(0.1 + 0.2)")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testBuildTimeAPI() throws {
        measure {
            let expectation = self.expectation(description: "API-keys fetched")
            //            XcodesModel().fetch()
            let url = URL(string: "https://www.runway.team/appreviewtimes")!
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode([XcodesResponse].self, from: data!)
                    expectation.fulfill()
                } catch {
                    print(error.localizedDescription)
                    XCTFail("Error")
                }
            }.resume()
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    }
    
    func testXcodes() throws {
        measure {
            let expectation = self.expectation(description: "API-keys fetched")
            //            XcodesModel().fetch()
            let url = URL(string: "https://xcodereleases.com/data.json")!
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode([XcodesResponse].self, from: data!)
                    expectation.fulfill()
                } catch {
                    print(error.localizedDescription)
                    XCTFail("Error")
                }
            }.resume()
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    }
}
