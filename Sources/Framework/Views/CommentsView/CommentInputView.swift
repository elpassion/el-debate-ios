import Foundation

class CommentInputView: UIView {

    let sendCommentButton: UIButton = Factory.sendCommentButton()
    let commentInputTextField: UITextField = Factory.commentInputTextField()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setupAutolayout()
    }

    private func addSubviews() {
        addSubview(sendCommentButton)
        addSubview(commentInputTextField)
    }

    private func setupAutolayout() {
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension CommentInputView {

    struct Factory {

        static func sendCommentButton() -> UIButton {
            let sendCommentButton = UIButton()
            return sendCommentButton
        }

        static func commentInputTextField() -> UITextField {
            let commentInputTextField = UITextField()
            return commentInputTextField
        }

    }

}
