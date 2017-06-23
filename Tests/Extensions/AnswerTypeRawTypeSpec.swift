//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import ELDebateFramework
import Nimble
import Quick

internal class AnswerTypeRawTypeSpec: QuickSpec {

    override func spec() {
        describe("AnswerType") {
            var sut: AnswerType?

            when("initializing from raw type") {
                whether("is initialized from non-string") {
                    beforeEach {
                        sut = AnswerType(rawType: 15)
                    }

                    it("should return nil") {
                        expect(sut).to(beNil())
                    }
                }

                whether("is initialized from improper raw value string") {
                    beforeEach {
                        sut = AnswerType(rawType: "This does not exist")
                    }

                    it("should return nil") {
                        expect(sut).to(beNil())
                    }
                }

                whether("is initialized from proper raw value string") {
                    beforeEach {
                        sut = AnswerType(rawType: AnswerType.positive.rawValue)
                    }

                    it("should return correct answer type") {
                        expect(sut) == AnswerType.positive
                    }
                }
            }
        }
    }

}
