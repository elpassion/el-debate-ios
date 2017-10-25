protocol CommentPresenting {
    func present(comment: Comment, in cell: SingleCommentCell)

}

class CommentPresenter: CommentPresenting {

    func present(comment: Comment, in cell: SingleCommentCell) {

        cell.singleCommentView.commentContextLabel.text = comment.content
        cell.singleCommentView.userNameLabel.text = comment.fullName
        cell.singleCommentView.dateLabel.text = comment.createdAt.asTimeString()
        cell.singleCommentView.userAvatarView.backgroundColor = UIColor(comment.userBackgroundColor)
        cell.singleCommentView.userInitialsLabel.text = comment.usersInitials

    }

}
