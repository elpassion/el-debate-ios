import PromiseKit
import PusherSwift
import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ControllerProviding {

    private let fetchCommentsService: FetchCommentsServiceProtocol
    private let commentsWebSocketService: CommentsWebSocketProtocol

    var comments: Comments?

    var voteContext: VoteContext

    init(fetchCommentsService: FetchCommentsServiceProtocol,
         commentsWebSocketService: CommentsWebSocketProtocol,
         voteContext: VoteContext) {
        self.fetchCommentsService = fetchCommentsService
        self.commentsWebSocketService = commentsWebSocketService
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

        commentsWebSocketService.startWebSocket()
        title = "Live Chat Feed"
    }

    var commentsView: CommentsView { return forceCast(view) }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.comments.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowNumber = indexPath.row
        guard let commentBody = comments?.comments[rowNumber] else {
            fatalError("Comment list should not be nil") }

        let cell = tableView.dequeueReusabelCell(SingleCommentCell.self, for: indexPath)
        cell.singleCommentView.commentContextLabel.text = commentBody.content
        cell.singleCommentView.userNameLabel.text = commentBody.fullName
        cell.singleCommentView.dateLabel.text = commentBody.createdAt.asTimeString()
        cell.singleCommentView.userAvatarView.backgroundColor = UIColor(commentBody.userBackgroundColor)
        cell.singleCommentView.userInitialsLabel.text = commentBody.usersInitials

        return cell
    }

    // MARK: - Fetch Comments Servie

    func fetchComments() {
        let authToken = voteContext.authToken
        _ = fetchCommentsService.fetchComments(authToken: authToken).then { [weak self] comments -> Void in
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
