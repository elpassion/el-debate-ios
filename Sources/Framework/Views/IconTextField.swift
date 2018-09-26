import Anchorage
import UIKit

class IconTextField: UIView {

    private let verticalStack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                         alignment: .center, spacing: 4.0)
    private let horizontalStack: UIStackView = Views.stack(axis: .horizontal, distribution: .fill,
                                                           alignment: .fill, spacing: 25.0)
    private let separator: UIView = UIView(frame: .zero)
    private let iconView: UIImageView
    private let textField: UITextField = UITextField(frame: .zero)

    init(icon: Image) {
        iconView = Views.image(image: icon, contentMode: .scaleAspectFit)

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    var value: String {
        get { return textField.text ?? "" }
        set { textField.text = newValue }
    }

    var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }

    var placeholder: String {
        get { return textField.placeholder ?? "" }
        set { textField.placeholder = newValue }
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        separator.backgroundColor = UIColor(predefined: .pin)

        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(AttributeStyle.enterPin.attributes.build().stringAny)
    }

    private func addSubviews() {
        horizontalStack.addArrangedSubview(iconView)
        horizontalStack.addArrangedSubview(textField)

        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(separator)

        addSubview(verticalStack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        verticalStack.edgeAnchors == edgeAnchors

        iconView.setContentHuggingPriority(.required, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)

        horizontalStack.widthAnchor == verticalStack.widthAnchor - 20.0

        separator.heightAnchor == 1
        separator.widthAnchor == verticalStack.widthAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
