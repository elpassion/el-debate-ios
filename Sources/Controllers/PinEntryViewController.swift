//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

class PinEntryViewController: UIViewController, PinEntryControllerProviding {

    private let loginActionHandler: LoginActionHandling
    private let yearCalculator: CurrentYearCalculating
    private let alertView: AlertShowing
    private let codeFieldAnimationRatio: CGFloat = 3.4

    var onVoteContextLoaded: ((VoteContext) -> Void)?

    // MARK: - Initializer

    init(loginActionHandler: LoginActionHandling, yearCalculator: CurrentYearCalculating, alertView: AlertShowing) {
        self.loginActionHandler = loginActionHandler
        self.yearCalculator = yearCalculator
        self.alertView = alertView

        super.init(nibName: nil, bundle: nil)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        view = PinEntryView()
    }

    var pinEntryView: PinEntryView {
        guard let pinEntryView = view as? PinEntryView else {
            fatalError("Expected to handle view of type PinEntryView, got \(type(of: view)) instead")
        }

        return pinEntryView
    }

    // MARK: - View did load

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EL Debate \(yearCalculator.year)"
        pinEntryView.onLoginButtonTapped = { [weak self] in self?.onLoginButtonTapped() }
        setupKeyboardNotifications()
    }

    func onLoginButtonTapped() {
        pinEntryView.setLoginButton(isEnabled: false)
        loginActionHandler.login(withPinCode: pinEntryView.pinCode).then { [weak self] voteContext -> Void in
            self?.onVoteContextLoaded?(voteContext)
        }.catch { [weak self] _ in
            guard let `self` = self else { return }
            self.alertView.show(in: self, title: "Error", message: "Could not find a debate for a given pin code")
        }.always { [weak self] in
            self?.pinEntryView.setLoginButton(isEnabled: true)
        }
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide),
                                               name: .UIKeyboardWillHide, object: nil)
    }

    @objc private func keyboardDidShow(payload: NSNotification) {
        guard let height = (payload.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue.height  else {
            return
        }

        pinEntryView.buttonBottom.constant = pinEntryView.buttonBottomBase - height
        pinEntryView.codeFieldBottom.constant = pinEntryView.codeFieldBottomBase - (height / codeFieldAnimationRatio)
        pinEntryView.layoutIfNeeded()
    }

    @objc private func keyboardDidHide(payload: NSNotification) {
        pinEntryView.buttonBottom.constant = pinEntryView.buttonBottomBase
        pinEntryView.codeFieldBottom.constant = pinEntryView.codeFieldBottomBase
        pinEntryView.layoutIfNeeded()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Controller providing

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
