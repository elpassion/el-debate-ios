@testable import ELDebateFramework
import Nimble
import Quick

class NavigationControllerFactorySpec: QuickSpec {

    override func spec() {
        var navigationControllerFactory: NavigationControllerFactory!

        describe("NavigationControllerFactory") {
            beforeEach {
                navigationControllerFactory = NavigationControllerFactory()
            }

            describe("makeNavigationController") {
                var navigationController: UINavigationController!

                beforeEach {
                    navigationController = navigationControllerFactory.makeNavigationController()
                }

                it("should set bar tint color") {
                    expect(navigationController.navigationBar.barTintColor) == UIColor(predefined: .navigationBar)
                }

                it("should set title color") {
                    let attributes = navigationController.navigationBar.titleTextAttributes

                    expect(attributes?[NSForegroundColorAttributeName] as? UIColor) == UIColor.white
                }

                it("should disable translucent navigation bar") {
                    expect(navigationController.navigationBar.isTranslucent).to(beFalse())
                }

                it("should set make status bar white") {
                    expect(navigationController.navigationBar.barStyle) == UIBarStyle.black
                }

                it("should set tint color to white") {
                    expect(navigationController.navigationBar.tintColor) == UIColor.white
                }
            }
        }
    }

}
