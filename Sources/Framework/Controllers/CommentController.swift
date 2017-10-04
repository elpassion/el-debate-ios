import PromiseKit
import UIKit

class CommentController: UIViewController, ControllerProviding {

    let voteContext: VoteContext
    private let inputAlertPresenter: InputAlertPresenting

    lazy var doDismiss: () -> Void = { [weak self] in
        self?.removeFromParentViewController()
        self?.view.removeFromSuperview()
    }

    init(voteContext: VoteContext, apiClient: APIProviding, inputAlertPresenter: InputAlertPresenting) {
        self.voteContext = voteContext
        self.inputAlertPresenter = inputAlertPresenter

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _ = inputAlertPresenter.prompt(in: self, with: inputAlertConfiguration).always { [weak self] in
                self?.doDismiss()
        }
    }

    private var inputAlertConfiguration: InputAlertConfiguration {
        return InputAlertConfiguration(title: "Chat is not available",
                                       message: "It will be fixed in next release, sorry :)",
                                       cancelTitle: "Cancel")
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
