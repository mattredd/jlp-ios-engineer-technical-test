//
//  BundleJSONTest.swift
//  jlp-ios-engineer-testTests
//
//  Created by Matthew Reddin on 27/05/2022.
//

import XCTest

class BundleJSONTest: XCTestCase {

    func testBundleJSONExtension() {
        XCTAssertNotNil(Bundle.main.jsonObject(from: "data", fileExtension: "json", type: ProductResponse.self), "Unable to load json object from the bundle.")
    }

}
