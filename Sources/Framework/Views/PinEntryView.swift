//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class PinEntryView: UIView {

    private let welcomeView: PinEntryWelcomeView = PinEntryWelcomeView()
    private let background: UIImageView = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
    private let loginButton: LoginButtonView = LoginButtonView()
    private let pinInputView: PinInputPanel = PinInputPanel()
    private let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    // MARK: - Public API

    var onLoginButtonTapped: (() -> Void)? {
        get { return loginButton.onLoginButtonTapped }
        set { loginButton.onLoginButtonTapped = newValue }
    }

    var credentials: LoginCredentials {
        get {
            return LoginCredentials(pin: pinInputView.pinCode, username: pinInputView.username)
        }
        set {
            pinInputView.pinCode = newValue.pin
            pinInputView.username = newValue.username
        }
    }

    var loginInProgress: Bool {
        get { return loginButton.loginInProgress }
        set { loginButton.loginInProgress = newValue }
    }

    func playKeyboardAnimation(height: CGFloat) {
        loginButtonBottonConstraint?.constant = loginButtonBottomSpacing - height
        centerPinInput(height == 0.0)
        layoutIfNeeded()
    }

    private func centerPinInput(_ shouldCenter: Bool) {
        pinInputCenterConstraint?.isActive = shouldCenter
        pinInputBottomConstraint?.isActive = !shouldCenter
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
        loginButton.dropShadow()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)
    }

    private func addSubviews() {
        addSubview(background)
        addSubview(welcomeView)
        addSubview(loginButton)
        addSubview(pinInputView)
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
        loginButtonBottonConstraint = loginButton.bottomAnchor == bottomAnchor + loginButtonBottomSpacing
        loginButton.widthAnchor == widthAnchor * 0.9
        loginButton.heightAnchor == heightAnchor * 0.08

        pinInputView.widthAnchor == loginButton.widthAnchor
        pinInputCenterConstraint = pinInputView.centerYAnchor == centerYAnchor
        pinInputView.centerXAnchor == centerXAnchor
        pinInputBottomConstraint = pinInputView.bottomAnchor == loginButton.topAnchor - 20

        centerPinInput(true)
    }

    private var loginButtonBottomSpacing: CGFloat = CGFloat(-15.0)
    var pinInputCenterConstraint: NSLayoutConstraint?
    var pinInputBottomConstraint: NSLayoutConstraint?
    var loginButtonBottonConstraint: NSLayoutConstraint?

    // MARK: - Gesture recognition

    private func setUpGestureRecognition() {
        tapGestureRecognizer.addTarget(self, action: #selector(didTapBackground))
        addGestureRecognizer(tapGestureRecognizer)
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
