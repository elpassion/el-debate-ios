import Anchorage
import UIKit

class PinInputPanel: UIView {

    private let stack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                 alignment: .fill, spacing: 25.0)
    private let codeInput: IconTextField = IconTextField(icon: .keyIcon)

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    var pinCode: String {
        get {
            return codeInput.value
        }
        set {
            codeInput.value = newValue
        }
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        codeInput.keyboardType = .numberPad
        codeInput.placeholder = "EL Debate PIN"
    }

    private func addSubviews() {
        stack.addArrangedSubview(codeInput)

        addSubview(stack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        stack.edgeAnchors == edgeAnchors
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
