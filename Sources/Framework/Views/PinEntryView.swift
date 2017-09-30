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
            return LoginCredentials(pin: pinInputView.pinCode)
        }
        set {
            pinInputView.pinCode = newValue.pin
        }
    }

    var loginInProgress: Bool {
        get { return loginButton.loginInProgress }
        set { loginButton.loginInProgress = newValue }
    }

    func playKeyboardAnimation(height: CGFloat) {
        loginButtonBottomConstraint?.constant = loginButtonBottomSpacing - height
        pinInputBottomConstraint?.constant = pinInputBottomSpacing + pinBottomOffset(forKeyboardHeight: height)

        layoutIfNeeded()
    }

    private func pinBottomOffset(forKeyboardHeight keyboardHeight: CGFloat) -> CGFloat {
        let currentBottomOffset = background.height - backgroundBottomSpacing - pinInputBottomSpacing
        let targetBottomOffset = keyboardHeight + loginButton.height - 2 * loginButtonBottomSpacing
        let additionalOffset = currentBottomOffset - targetBottomOffset

        return min(additionalOffset, 0.0)
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
        background.bottomAnchor == bottomAnchor + backgroundBottomSpacing
        background.widthAnchor == widthAnchor * 0.95
        background.heightAnchor == background.widthAnchor * 0.75

        loginButton.centerXAnchor == centerXAnchor
        loginButtonBottomConstraint = loginButton.bottomAnchor == bottomAnchor + loginButtonBottomSpacing
        loginButton.widthAnchor == widthAnchor * 0.9
        loginButton.heightAnchor == heightAnchor * 0.08

        pinInputView.widthAnchor == loginButton.widthAnchor
        pinInputView.centerXAnchor == centerXAnchor
        pinInputBottomConstraint = pinInputView.bottomAnchor == background.topAnchor + pinInputBottomSpacing
    }

    private let backgroundBottomSpacing: CGFloat = CGFloat(-20.0)
    private let loginButtonBottomSpacing: CGFloat = CGFloat(-15.0)
    private let pinInputBottomSpacing: CGFloat = CGFloat(-10.0)
    var pinInputBottomConstraint: NSLayoutConstraint?
    var loginButtonBottomConstraint: NSLayoutConstraint?

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
