import PromiseKit
import UIKit

class CommentController: UIViewController, ControllerProviding {

    let voteContext: VoteContext

    init(voteContext: VoteContext, apiClient: APIProviding) {
        self.voteContext = voteContext

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
