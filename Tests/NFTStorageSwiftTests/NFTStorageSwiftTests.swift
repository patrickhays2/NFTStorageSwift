import XCTest
@testable import NFTStorageSwift

final class NFTStorageSwiftTests: XCTestCase {
    let nfts = NFTStorageAPI("your-api-key")
    func testUploadStringData() {
        nfts.uploadStringData("0123456789") {result,message,data in
            XCTAssertTrue(result)
            XCTAssertEqual(message,"Data uploaded successfully.")
            XCTAssertEqual(message,"https://bafk...3yqi.ipfs.dweb.link")
        }
    }
    
    func testDeleteData() {
        nfts.deleteData("bafk...3yqi") {result,message,data in
            XCTAssertTrue(result)
            XCTAssertEqual(message,"File deleted successfully.")
            XCTAssertEqual(message,"None")
        }
    }
}
