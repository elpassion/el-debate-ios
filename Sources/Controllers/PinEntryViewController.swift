//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

class PinEntryViewController: UIViewController, PinEntryControllerProviding, AlertPresentingController {

    private let loginActionHandler: LoginActionHandling
    let alertPresenter: AlertShowing
    private let keyboardHandling: KeyboardWillShowHandling

    var onVoteContextLoaded: ((VoteContext) -> Void)?

    // MARK: - Initializer

    init(loginActionHandler: LoginActionHandling, alertView: AlertShowing, keyboardHandling: KeyboardWillShowHandling) {
        self.loginActionHandler = loginActionHandler
        self.alertPresenter = alertView
        self.keyboardHandling = keyboardHandling

        super.init(nibName: nil, bundle: nil)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        view = PinEntryView()
    }

    var pinEntryView: PinEntryView { return forceCast(view) }

    // MARK: - View did load

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EL Debate"
        pinEntryView.onLoginButtonTapped = { [weak self] in self?.onLoginButtonTapped() }
        setupKeyboardNotifications()
    }

    func onLoginButtonTapped() {
        pinEntryView.loginInProgress = true

        loginActionHandler.login(withPinCode: pinEntryView.pinCode)
            .then { [weak self] voteContext -> Void in
                self?.didFetchVoteContext(voteContext)
            }.catch { [weak self] _ in
                presentAlert(in: self, title: "Error", message: "Could not find a debate for a given pin code")
            }.always { [weak self] in
                self?.pinEntryView.loginInProgress = false
            }
    }

    private func setupKeyboardNotifications() {
        keyboardHandling.onKeyboardHeightChanged = { [weak self] height in
            self?.pinEntryView.playKeyboardAnimation(height: height)
        }
    }

    private func didFetchVoteContext(_ voteContext: VoteContext) {
        let contextWithUsername = voteContext.copy(withUsername: pinEntryView.username)

        view.endEditing(true)
        onVoteContextLoaded?(contextWithUsername)
    }

    // MARK: - Controller providing

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
