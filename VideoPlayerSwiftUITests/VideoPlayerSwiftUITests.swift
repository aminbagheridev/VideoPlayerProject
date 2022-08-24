//
//  VideoPlayerSwiftUITests.swift
//  VideoPlayerSwiftUITests
//
//  Created by Michael Gauthier on 2021-01-06.
//

import XCTest
@testable import VideoPlayerSwiftUI

class VideoPlayerSwiftUITests: XCTestCase {
    
    // MARK: Make sure the server is running, or else this will fail.
    func testAPIWorking() {
        
        let exp = self.expectation(description: "myExpectation")
        
        VideoCaller.shared.getVideos { result in
            
            switch result {
            case .success(let videos):
                XCTAssert(videos.first?.id != nil)
                // The request is finished, so our expectation
                exp.fulfill()
            case .failure(_):
                XCTFail("Fail")
                // The request is finished, so our expectation
                exp.fulfill()
            }
        }
        // We ask the unit test to wait our expectation to finish.
        self.waitForExpectations(timeout: 5)
    }
}
