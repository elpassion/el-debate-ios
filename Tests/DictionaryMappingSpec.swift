//
//  Created by Jakub Turek on 17.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class DictionaryMappingSpec: QuickSpec {

    override func spec() {
        describe("Dictionary") {
            describe("mapValues") {
                it("should return mapped values") {
                    let dictionary: [String: Int] = ["A": 1, "B": 2, "C": 3]

                    let mapped = dictionary.mapValues { "\($0)" }

                    expect(mapped).to(equal(["A": "1", "B": "2", "C": "3"]))
                }
            }
        }
    }
}
