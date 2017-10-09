import PromiseKit
import UIKit

class CommentController: UIViewController, ControllerProviding {

    let voteContext: VoteContext

    init(voteContext: VoteContext, apiClient: APIProviding) {
        self.voteContext = voteContext

        super.init(nibName: nil, bundle: nil)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back to Voting",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }

    override func loadView() {
        view = ChatFeedView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Live Chat Feed"
    }

     var chatFeedView: ChatFeedView { return forceCast(view) }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
