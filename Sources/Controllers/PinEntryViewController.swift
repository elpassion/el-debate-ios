//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

class PinEntryViewController: UIViewController, PinEntryControllerProviding {

    private let loginActionHandler: LoginActionHandling
    private let yearCalculator: CurrentYearCalculating

    var onSuccessfulLogin: ((String) -> Void)?

    // MARK: - Initializer

    init(loginActionHandler: LoginActionHandling, yearCalculator: CurrentYearCalculating) {
        self.loginActionHandler = loginActionHandler
        self.yearCalculator = yearCalculator

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
    }

    private func onLoginButtonTapped() {
        loginActionHandler.login(withPinCode: pinEntryView.pinCode).then { [weak self] authToken in
            self?.onSuccessfulLogin?(authToken)
        }.catch { error in
            fatalError(error.localizedDescription)
        }
    }

    // MARK: - Controller providing

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
