//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class PinEntryView: UIView {

    private let welcomeView: PinEntryWelcomeView = PinEntryWelcomeView()
    private let background: UIImageView = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
    private let loginButton: UIButton = Views.button(style: .buttonTitle, backgroundColor: .navigationBar,
                                                     cornerRadius: 3.0, title: "Log in")
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    private let pinInputView: PinInputPanel = PinInputPanel()
    private let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    private let buttonConstraintValue: CGFloat = CGFloat(-15.0)
    private let codeFieldConstraintValue: CGFloat = CGFloat(-20.0)
    private let codeFieldAnimationRatio: CGFloat = CGFloat(7.0)

    private var codeFieldBottomConstraint: NSLayoutConstraint?
    var buttonBottomConstraint: NSLayoutConstraint?

    var onLoginButtonTapped: (() -> Void)?

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
            return pinInputView.pinCode
        }
        set {
            pinInputView.pinCode = newValue
        }
    }

    func showLogin(inProgress: Bool) {
        let backgroundColor: Color = inProgress ? .pin : .navigationBar
        loginButton.isEnabled = !inProgress
        loginButton.backgroundColor = UIColor(predefined: backgroundColor)
        activityIndicator.isHidden = loginButton.isEnabled

        if inProgress {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func playKeyboardAnimation(height: CGFloat) {
        buttonBottomConstraint?.constant = buttonConstraintValue - height
        codeFieldBottomConstraint?.constant = codeFieldConstraintValue - (height / codeFieldAnimationRatio)
        layoutIfNeeded()
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
        loginButton.dropShadow()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)

        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)

        activityIndicator.isHidden = true
    }

    private func addSubviews() {
        addSubview(background)
        addSubview(welcomeView)
        addSubview(loginButton)
        addSubview(pinInputView)
        addSubview(activityIndicator)
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
        loginButton.heightAnchor == heightAnchor * 0.08

        pinInputView.widthAnchor == loginButton.widthAnchor
        codeFieldBottomConstraint = pinInputView.bottomAnchor == background.topAnchor + codeFieldAnimationRatio
        pinInputView.centerXAnchor == centerXAnchor

        activityIndicator.centerYAnchor == loginButton.centerYAnchor
        activityIndicator.trailingAnchor == loginButton.trailingAnchor - 12.0
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
