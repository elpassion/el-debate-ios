//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class PinEntryView: UIView {

    private let welcomeView: PinEntryWelcomeView = PinEntryWelcomeView()
    private let background: UIImageView = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
    private let loginButton: UIButton = UIButton(type: .custom)
    private let codeField: PinEntryCodeField = PinEntryCodeField()
    private let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    private let buttonConstraintValue: CGFloat = CGFloat(-15.0)
    private let codeFieldConstraintValue: CGFloat = CGFloat(-20.0)
    private let codeFieldAnimationRatio: CGFloat = CGFloat(3.4)

    private var codeFieldBottomConstraint: NSLayoutConstraint?
    var buttonBottomConstraint: NSLayoutConstraint?

    var onLoginButtonTapped: (() -> Void)?
    var onCommentButtonTapped: (() -> Void)?

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    // MARK: - Public API

    var pinCode: String {
        get {
            return codeField.pinCode
        }
        set {
            codeField.pinCode = newValue
        }
    }

    func setLoginButton(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
    }

    func playKeyboardAnimation(height: CGFloat) {
        buttonBottomConstraint?.constant = buttonConstraintValue - height
        codeFieldBottomConstraint?.constant = codeFieldConstraintValue - (height / codeFieldAnimationRatio)
        layoutIfNeeded()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)

        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.setBackgroundImage(UIImage(predefined: .buttonBackground), for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0)
    }

    private func addSubviews() {
        addSubview(background)
        addSubview(welcomeView)
        addSubview(loginButton)
        addSubview(codeField)
    }

    // MARK: - Layout

    private func setUpLayout() {
        welcomeView.topAnchor == topAnchor + 30
        welcomeView.widthAnchor == widthAnchor * 0.5
        welcomeView.centerXAnchor == centerXAnchor

        background.centerXAnchor == centerXAnchor
        background.bottomAnchor == bottomAnchor - 20
        background.widthAnchor == widthAnchor * 0.95
        background.heightAnchor == background.widthAnchor * 0.75

        loginButton.centerXAnchor == centerXAnchor
        buttonBottomConstraint = loginButton.bottomAnchor == bottomAnchor + buttonConstraintValue
        loginButton.widthAnchor == widthAnchor * 0.9

        codeField.widthAnchor == loginButton.widthAnchor
        codeFieldBottomConstraint = codeField.bottomAnchor == background.topAnchor + codeFieldConstraintValue
        codeField.centerXAnchor == centerXAnchor
    }

    // MARK: - Gesture recognition

    private func setUpGestureRecognition() {
        tapGestureRecognizer.addTarget(self, action: #selector(didTapBackground))
        addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Login button tap

    @objc
    private func didTapLoginButton() {
        onLoginButtonTapped?()
    }

    // MARK: - Background tap

    @objc
    private func didTapBackground() {
        endEditing(true)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
