import PromiseKit
import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ControllerProviding {

    private let fetchCommentsService: FetchCommentsServiceProtocol

    var comments: Comments?

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
        view = CommentsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchComments()
        commentsView.commentsTableView.registerCell(SingleCommentCell.self)
        commentsView.commentsTableView.dataSource = self

        title = "Live Chat Feed"
    }

    var commentsView: CommentsView { return forceCast(view) }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let commentsCount = comments?.comments.count else {
            return 0 }
        return commentsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowNumber = indexPath.row
        guard let commentBody = comments?.comments[rowNumber].content else {
            fatalError("Comment list should not be nil") }

        let cell = tableView.dequeueReusabelCell(SingleCommentCell.self, for: indexPath)

        return cell
    }

    // MARK: - Fetch Comments Servie

    func fetchComments() {
        let authToken = voteContext.authToken
        fetchCommentsService.fetchComments(authToken: authToken).then { [weak self] comments -> Void in
            self?.comments = comments
            self?.commentsView.commentsTableView.reloadData()
        }
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
