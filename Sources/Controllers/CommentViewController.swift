//
//  CommentViewController.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

class CommentViewController: UIViewController, CommentControllerProviding, AlertPresentingController {

    private let authToken: String
    private let apiClient: APIProviding
    let alertPresenter: AlertShowing
    private let loadingView: LoadingViewShowing
    private let keyboardHandling: KeyboardWillShowHandling

    var onCommentSubmitted: (() -> Void)?

    init(authToken: String, apiClient: APIProviding, alertView: AlertShowing,
         loadingView: LoadingViewShowing, keyboardHandling: KeyboardWillShowHandling) {
        self.authToken = authToken
        self.apiClient = apiClient
        self.alertPresenter = alertView
        self.loadingView = loadingView
        self.keyboardHandling = keyboardHandling

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = CommentView()
    }

    var commentView: CommentView { return forceCast(view) }

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        title = "Comment"
        commentView.onSubmitButtonTapped = { [weak self] in self?.onSubmitButtonTapped() }

        setupKeyboardNotifications()
    }

    private func onSubmitButtonTapped() {
        loadingView.show(in: self)

        apiClient.comment(authToken: authToken, text: commentView.commentText)
            .then { [weak self] _ -> Promise<Bool> in
                presentAlert(in: self, title: nil, message: "Your comment was submitted")
            }.then { _ -> Void in
                self.onCommentSubmitted?()
            }.catch { [weak self] _ -> Void in
                presentAlert(in: self, title: "Error", message: "There was a problem submitting your comment")
            }.always { [weak self] in
                self?.loadingView.hide()
            }
    }

    private func setupKeyboardNotifications() {
        keyboardHandling.onKeyboardHeightChanged = { [weak self] height in
            self?.commentView.playKeyboardAnimation(height: height)
        }
    }
    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
