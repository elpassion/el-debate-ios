import Anchorage
import UIKit

class LoginButtonView: UIView {

    private let loginButton: UIButton = Views.button(style: .buttonTitle, backgroundColor: .navigationBar,
                                                     cornerRadius: 3.0, title: "Log in")
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)

    var onLoginButtonTapped: (() -> Void)?

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    var loginInProgress: Bool = false {
        didSet {
            loginButton.isEnabled = !loginInProgress
            activityIndicator.isHidden = loginButton.isEnabled

            if loginInProgress {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
        loginButton.setBackgroundImage(.from(color: .highlightedButton), for: .highlighted)

        activityIndicator.isHidden = true
    }

    private func addSubviews() {
        addSubview(loginButton)
        addSubview(activityIndicator)
    }

    // MARK: - Layout

    private func setUpLayout() {
        loginButton.edgeAnchors == edgeAnchors

        activityIndicator.centerYAnchor == centerYAnchor
        activityIndicator.leadingAnchor == loginButton.leadingAnchor + 12.0
    }

    // MARK: - Login button tap

    @objc
    private func didTapLoginButton() {
        onLoginButtonTapped?()
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
