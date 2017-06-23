//
//  CommentViewController.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

class CommentController: UIViewController, ControllerProviding {

    let voteContext: VoteContext
    private let apiClient: APIProviding
    private let inputAlertPresenter: InputAlertPresenting

    lazy var doDismiss: () -> Void = { [weak self] in
        self?.removeFromParentViewController()
        self?.view.removeFromSuperview()
    }

    init(voteContext: VoteContext, apiClient: APIProviding, inputAlertPresenter: InputAlertPresenting) {
        self.voteContext = voteContext
        self.apiClient = apiClient
        self.inputAlertPresenter = inputAlertPresenter

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _ = inputAlertPresenter.prompt(in: self, with: inputAlertConfiguration)
            .then { [weak self] comment in
                self?.didSendComment(comment)
            }.always { [weak self] in
                self?.doDismiss()
            }
    }

    private func didSendComment(_ comment: String?) -> Promise<Bool> {
        guard let comment = comment else {
            return Promise(value: false)
        }

        return apiClient.comment(comment, with: voteContext)
    }

    private var inputAlertConfiguration: InputAlertConfiguration {
        return InputAlertConfiguration(title: nil, message: "Add a comment", cancelTitle: "Cancel",
                                       okTitle: "Send", inputPlaceholder: "Comment")
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
