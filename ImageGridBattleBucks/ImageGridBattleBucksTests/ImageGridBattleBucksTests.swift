//
//  ImageGridBattleBucksTests.swift
//  ImageGridBattleBucksTests
//
//  Created by STUPA-TECH on 27/09/24.
//

import XCTest
@testable import ImageGridBattleBucks

final class ImageGridBattleBucksTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
class HTTPUtilitiesTests: XCTestCase {

    var httpUtilities: HTTPUtilities!
    
    override func setUp() {
        super.setUp()
        httpUtilities = HTTPUtilities.shared
    }

    override func tearDown() {
        httpUtilities = nil
        super.tearDown()
    }

    // Test 1: Verify that the cache is used correctly
    func testImageCaching() {
        let testURL = "https://example.com/testImage.png"
        let testImage = UIImage(systemName: "star")! // Create a sample image
        
        // Manually cache the image
        httpUtilities.cache.setObject(testImage, forKey: testURL as NSString)
        
        // Try loading the image again
        let expectation = self.expectation(description: "Image loaded from cache")
        
        httpUtilities.loadImage(url: testURL) { image in
            XCTAssertNotNil(image, "Image should not be nil")
            XCTAssertEqual(image, testImage, "Image should be loaded from cache")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // Test 2: Verify that the image loads properly from the network
    func testImageLoadingFromNetwork() {
        let testURL = "https://via.placeholder.com/150" // Use a valid URL
        
        let expectation = self.expectation(description: "Image loaded from network")
        
        httpUtilities.loadImage(url: testURL) { image in
            XCTAssertNotNil(image, "Image should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    // Test 3: Verify behavior with an invalid URL
    func testImageLoadingWithInvalidURL() {
        let invalidURL = "invalid_url"
        
        let expectation = self.expectation(description: "Image loading failed due to invalid URL")
        
        httpUtilities.loadImage(url: invalidURL) { image in
            XCTAssertNil(image, "Image should be nil for an invalid URL")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // Test 4: Verify that the completion handler is called with nil if image loading fails
    func testImageLoadingFailure() {
        
        let testURL = "https://invalid-url.com/invalid-image.png"
        
        let expectation = self.expectation(description: "Image loading should fail")
        
        httpUtilities.loadImage(url: testURL) { image in
            XCTAssertNil(image, "Image should be nil when loading fails")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
