//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class AppDelegateSpec: QuickSpec {

    override func spec() {
        var router: RouterMock!
        var appDelegate: AppDelegate!

        describe("AppDelegate") {
            beforeEach {
                router = RouterMock()
                appDelegate = AppDelegate()
                appDelegate.router = router
            }

            describe("starting application") {
                var launchReturnValue: Bool!

                beforeEach {
                    launchReturnValue = appDelegate.application(.shared, didFinishLaunchingWithOptions: nil)
                }

                it("should set window") {
                    expect(appDelegate.window).toNot(beNil())
                }

                it("should start router") {
                    expect(router.lastRoute).to(equal(Route.pinEntry))
                }

                it("should return true") {
                    expect(launchReturnValue).to(beTrue())
                }
            }
        }
    }
}
