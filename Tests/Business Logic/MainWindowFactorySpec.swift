//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Quick

class MainWindowFactorySpec: QuickSpec {

    override func spec() {
        var mainWindowFactory: MainWindowFactory!

        describe("MainWindowFactory") {
            beforeEach {
                mainWindowFactory = MainWindowFactory(screenBounds: UIScreen.main.bounds)
            }

            describe("makeMainWindow") {
                var navigationController: UINavigationController!
                var window: UIWindow!

                beforeEach {
                    navigationController = UINavigationController()
                    window = mainWindowFactory.makeMainWindow(with: navigationController)
                }

                it("should create window with white background") {
                    expect(window.backgroundColor) == UIColor.white
                }

                it("should create key window") {
                    expect(window.isKeyWindow).to(beTrue())
                }

                it("should set navigation controller as root") {
                    expect(window.rootViewController).to(be(navigationController))
                }
            }
        }
    }

}
