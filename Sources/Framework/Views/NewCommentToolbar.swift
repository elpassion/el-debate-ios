import Anchorage
import UIKit

class NewCommentToolbar: UIView {
    let textField: UITextField = NewCommentToolbar.createTextField()
    let button: UIButton = NewCommentToolbar.createButton()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 49))

        backgroundColor = .white

        addSubview(textField)
        addSubview(button)
        setupLayout()
    }

    private func setupLayout() {
        textField.leftAnchor == leftAnchor + 10
        textField.topAnchor == topAnchor + 10
        textField.bottomAnchor == bottomAnchor - 10
        textField.rightAnchor == button.leftAnchor - 13

        button.rightAnchor == rightAnchor - 13
        button.bottomAnchor == textField.bottomAnchor
        button.topAnchor == textField.topAnchor
        button.widthAnchor == 40
    }

    // Mark - required

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewCommentToolbar {
    static func createTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Your message"
        return textField
    }

    static func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        return button
    }
}
