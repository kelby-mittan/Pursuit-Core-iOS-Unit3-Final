//
//  ElementsTests.swift
//  ElementsTests
//
//  Created by Kelby Mittan on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import XCTest

@testable import Elements

class ElementsTests: XCTestCase {

    func testElementCount() {
                
        let exp = XCTestExpectation(description: "searches found")
        let episodesEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        
        let request = URLRequest(url: URL(string: episodesEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("\(appError)")
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([Element].self, from: data)
                    let elements = searchResults
                    
                    XCTAssertEqual(elements.count, 100, "Should be 100")
                } catch {
                    XCTFail()
                }
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }

}
