//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class AppDelegateSpec: QuickSpec {

    override func spec() {
        var appDelegate: AppDelegate!

        describe("AppDelegate") {
            beforeEach {
                appDelegate = AppDelegate()
            }

            describe("starting application") {
                beforeEach {
                    _ = appDelegate.application(.shared, didFinishLaunchingWithOptions: nil)
                }

                it("should set window") {
                    expect(appDelegate.window).toNot(beNil())
                }
            }
        }
    }
}
