import UIKit

class ChildControllerSpy: UIViewController {

    var addedChild: UIViewController?
    var willMoveCalledTo: UIViewController?
    var didMoveCalledTo: UIViewController?

    override func addChildViewController(_ childController: UIViewController) {
        addedChild = childController
    }

    override func willMove(toParentViewController parent: UIViewController?) {
        willMoveCalledTo = parent
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        didMoveCalledTo = parent
    }

}
