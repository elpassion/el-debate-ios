import Anchorage
import Foundation

class CommentInputView: UIView {

    let commentInputTextField: UITextField = Factory.commentInputTextField()
    let sendCommentButton: UIButton = Factory.sendCommentButton()

    init() {
        super.init(frame: .zero)

        setupViews()
        addSubviews()
        setupAutolayout()
    }

    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9272789832, green: 0.9272789832, blue: 0.9272789832, alpha: 1)
    }

    private func addSubviews() {
        addSubview(commentInputTextField)
        addSubview(sendCommentButton)
    }

    private func setupAutolayout() {
        commentInputTextField.topAnchor == topAnchor + 5
        commentInputTextField.bottomAnchor >= bottomAnchor - 5
        commentInputTextField.leftAnchor == leftAnchor + 5

        sendCommentButton.leftAnchor == commentInputTextField.rightAnchor + 5
        sendCommentButton.rightAnchor == rightAnchor - 5
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension CommentInputView {

    struct Factory {

        static func commentInputTextField() -> UITextField {
            let commentInputTextField = UITextField()
            commentInputTextField.placeholder = "Enter Your Comment Here"
            commentInputTextField.backgroundColor = UIColor.white
            commentInputTextField.autocorrectionType = .no
            commentInputTextField.autocapitalizationType = .none
            commentInputTextField.borderStyle = .roundedRect
            return commentInputTextField
        }

        static func sendCommentButton() -> UIButton {
            let sendCommentButton = UIButton()
            return sendCommentButton
        }

    }

}
