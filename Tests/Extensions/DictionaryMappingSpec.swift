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
                it("should return dictionary with mapped values") {
                    let dictionary: [String: Int] = ["A": 1, "B": 2, "C": 3]

                    let mapped = dictionary.mapValues { "\($0)" }

                    expect(mapped).to(equal(["A": "1", "B": "2", "C": "3"]))
                }
            }

            describe("map") {
                it("should return dictionary with mapped entries") {
                    let dictionary: [String: Int] = ["A": 1, "B": 2, "C": 3]

                    let mapped = dictionary.mapDictionary { (key, value) in (value, key) }

                    expect(mapped).to(equal([1: "A", 2: "B", 3: "C"]))
                }
            }
        }
    }

}
