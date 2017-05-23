//
//  CommentViewController.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit
import UIKit

class CommentViewController: UIViewController, CommentControllerProviding {
    private let authToken: String
    private let apiClient: APIProviding
    private let alertView: AlertShowing
    private let loadingView: LoadingViewShowing

    var controller: UIViewController { return self }
    var onCommentSubmitted: (() -> Void)?

    var commentView: CommentView {
        guard let commentView = view as? CommentView else { fatalError("Could not cast to CommentView") }
        return commentView
    }

    init(authToken: String, apiClient: APIProviding, alertView: AlertShowing, loadingView: LoadingViewShowing) {
        self.authToken = authToken
        self.apiClient = apiClient
        self.alertView = alertView
        self.loadingView = loadingView

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = CommentView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        title = "Comment"
        commentView.onSubmitButtonTapped = { [weak self] in self?.onSubmitButtonTapped() }
    }

    func onSubmitButtonTapped() {
        loadingView.show(in: self)
        apiClient.comment(authToken: authToken, text: commentView.commentText)
        .then { [weak self] _ -> Promise<Bool> in
            guard let `self` = self else { return Promise(error: RequestError.deallocatedClientError) }
            return self.alertView.show(in: self, title: "", message: "Your comment was submitted")
        }.then { _ -> Void in
           self.onCommentSubmitted?()
        }.catch { [weak self] _ -> Void in
            guard let `self` = self else { return }
            self.alertView.show(in: self, title: "Error", message: "There was a problem submitting your comment" )
        }.always { [weak self] in
            self?.loadingView.hide()
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
