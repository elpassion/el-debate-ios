import UIKit

class ChildControllerSpy: UIViewController {

    var addedChild: UIViewController?
    var willMoveCalledTo: UIViewController?
    var didMoveCalledTo: UIViewController?

    override func addChild(_ childController: UIViewController) {
        addedChild = childController
    }

    override func willMove(toParent parent: UIViewController?) {
        willMoveCalledTo = parent
    }

    override func didMove(toParent parent: UIViewController?) {
        didMoveCalledTo = parent
    }

}
