protocol CommentPresenting {
    func present(comment: Comment, in cell: SingleCommentCell)

}

class CommentPresenter: CommentPresenting {

    init(commentPresenter: CommentPresenting) {
        self.commentPresenter = commentPresenter
    }

    func present(comment: Comment, in cell: SingleCommentCell) {
        commentPresenter.present(comment: comment, in: cell)

        cell.singleCommentView.commentContextLabel.text = comment.content
        cell.singleCommentView.userNameLabel.text = comment.fullName
        cell.singleCommentView.dateLabel.text = comment.createdAt.asTimeString()
        cell.singleCommentView.userAvatarView.backgroundColor = UIColor(comment.userBackgroundColor)
        cell.singleCommentView.userInitialsLabel.text = comment.usersInitials

    }

    // MARK: - Privates

    private let commentPresenter: CommentPresenting

}
