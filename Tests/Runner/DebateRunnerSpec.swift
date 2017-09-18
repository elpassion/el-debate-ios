@testable import ELDebateFramework
import Nimble
import Quick
import Swinject
import UIKit

internal class DebateRunnerSpec: QuickSpec {

    override func spec() {
        describe("DebateRunner") {
            var navigationController: UINavigationController!
            var sut: DebateRunner!

            beforeEach {
                guard let assembler = try? Assembler(assemblies: [DebateRunnerAssembly()]) else {
                    fatalError("Could not build testing assembly")
                }

                navigationController = UINavigationController()
                sut = DebateRunner(resolver: assembler.resolver)
            }

            when("starting") {
                beforeEach {
                    sut.start(in: navigationController, applyingDebateStyle: true)
                }

                it("should create a new router with navigation controller") {
                    expect(sut.router).toNot(beNil())
                    expect(sut.router?.navigator) == navigationController
                }

                it("should navigate to pin entry screen") {
                    var navigatedToPinEntry = false

                    if case .some(.pinEntry) = sut.routerMock?.lastRoute {
                        navigatedToPinEntry = true
                    }

                    expect(navigatedToPinEntry) == true
                }

                whether("debate style is applied") {
                    beforeEach {
                        navigationController.navigationBar.barTintColor = .white
                        sut.start(in: navigationController, applyingDebateStyle: true)
                    }

                    it("should apply debate style on navigation controller (set tint color)") {
                        expect(navigationController.navigationBar.barTintColor) == UIColor(predefined: .navigationBar)
                    }
                }

                whether("debate style is not applied") {
                    beforeEach {
                        navigationController.navigationBar.barTintColor = .white
                        sut.start(in: navigationController, applyingDebateStyle: false)
                    }

                    it("should not apply debate style on navigation controller (set tint color)") {
                        expect(navigationController.navigationBar.barTintColor) != UIColor(predefined: .navigationBar)
                    }
                }
            }
        }
    }

}

extension DebateRunner {

    fileprivate var routerMock: RouterMock? {
        return router as? RouterMock
    }

}
