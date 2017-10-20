import PromiseKit
import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ControllerProviding {

    private let fetchCommentsService: FetchCommentsServiceProtocol

    var voteContext: VoteContext

    init(fetchCommentsService: FetchCommentsServiceProtocol,
         voteContext: VoteContext) {
        self.fetchCommentsService = fetchCommentsService
        self.voteContext = voteContext

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

    // MARK: - TableView Configuration

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SingleCommentView.self()
        return cell
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
