import PromiseKit
import UIKit

class CommentViewController: UIViewController, ControllerProviding {

    init() {

        super.init(nibName: nil, bundle: nil)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back to Voting",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }

    override func loadView() {
        view = ChatView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Live Chat Feed"
    }

    var chatView: ChatView { return forceCast(view) }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
