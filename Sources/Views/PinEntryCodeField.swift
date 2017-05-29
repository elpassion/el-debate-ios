//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class PinEntryCodeField: UIView {

    private let verticalStack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                         alignment: .center, spacing: 4.0)
    private let horizontalStack: UIStackView = Views.stack(axis: .horizontal, distribution: .fill,
                                                           alignment: .fill, spacing: 25.0)
    private let separator: UIView = UIView(frame: .zero)
    private let keyIcon: UIImageView = Views.image(image: .keyIcon, contentMode: .scaleAspectFit)
    private let codeInput: UITextField = UITextField(frame: .zero)

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    var pinCode: String {
        get {
            return codeInput.text ?? ""
        }
        set {
            codeInput.text = newValue
        }
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        separator.backgroundColor = UIColor(predefined: .pin)

        codeInput.keyboardType = .numberPad
        codeInput.textAlignment = .left
        codeInput.textColor = UIColor(predefined: .pin)
        codeInput.placeholder = "Enter EL Debate PIN"
        codeInput.font = UIFont.systemFont(ofSize: 19.0)
    }

    private func addSubviews() {
        horizontalStack.addArrangedSubview(keyIcon)
        horizontalStack.addArrangedSubview(codeInput)

        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(separator)

        addSubview(verticalStack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        verticalStack.edgeAnchors == edgeAnchors

        keyIcon.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        codeInput.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)

        horizontalStack.widthAnchor == verticalStack.widthAnchor - 20.0

        separator.heightAnchor == 1
        separator.widthAnchor == verticalStack.widthAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
