import XCTest

@testable import daikiri_swift

class daikiri_swiftTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func test_can_create() {
        let spiderman = Hero("Spiderman", age:16)
        spiderman.create()
        
        let all = Hero.all()
        XCTAssertEqual(1, all.count)
    }

    

}
