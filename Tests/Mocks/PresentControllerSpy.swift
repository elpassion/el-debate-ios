import UIKit

internal class PresentControllerSpy: UIViewController {

    var hasPresentedController: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        self.hasPresentedController = viewControllerToPresent
    }

}
