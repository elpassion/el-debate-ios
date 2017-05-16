//
//  FeatureTests.swift
//  FeatureTests
//
//  Created by Jakub Turek on 16.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import EarlGrey
import XCTest

class FeatureTests: XCTestCase {
    
    func testWindowIsVisible() {
        EarlGrey.select(elementWithMatcher: grey_keyWindow())
            .assert(grey_sufficientlyVisible())
    }
    
}
