//
//  Created by Jakub Turek on 26.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class KeyboardWillShowPayloadSpec: QuickSpec {

    override func spec() {
        describe("KeyboardWillShowPayloadSpec") {
            describe("init from user dictionary") {
                it("should return nil if there is no UIKeyboardFrameEndUserInfoKey") {
                    let userInfo: [AnyHashable: Any] = ["Hello": "World"]

                    let result = KeyboardWillShowPayload(userInfo: userInfo)

                    expect(result).to(beNil())
                }

                it("should correctly parse payload if there is UIKeyboardFrameEndUserInfoKey") {
                    let rect = CGRect(x: 15.0, y: 25.0, width: 35.0, height: 55.0)
                    let userInfo: [AnyHashable: Any] = ["UIKeyboardFrameEndUserInfoKey": NSValue(cgRect: rect)]

                    let result = KeyboardWillShowPayload(userInfo: userInfo)

                    expect(result).toNot(beNil())
                }

                it("should correctly calculate height correctly") {
                    let rect = CGRect(x: 15.0, y: 25.0, width: 35.0, height: 55.0)
                    let userInfo: [AnyHashable: Any] = ["UIKeyboardFrameEndUserInfoKey": NSValue(cgRect: rect)]

                    let result = KeyboardWillShowPayload(userInfo: userInfo)

                    expect(result?.height) == 55.0
                }
            }
        }
    }

}
