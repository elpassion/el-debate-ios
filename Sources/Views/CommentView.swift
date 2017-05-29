//
//  CommentView.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class CommentView: UIView {

    private let submitButton = UIButton(type: .custom)
    private let contentTextField = UITextView(frame: .zero)
    private let viewTapGestureRecognizer = UITapGestureRecognizer()

    var buttonBottom: NSLayoutConstraint?

    var onSubmitButtonTapped: (() -> Void)?

    var commentText: String {
        return contentTextField.text
    }

    init() {
        super.init(frame: .zero)
        setupSubviews()
        addSubviews()
        setupLayout()
    }

    private func setupSubviews() {
        backgroundColor = .white
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        viewTapGestureRecognizer.addTarget(self, action: #selector(self.hideKeyboard))
        addGestureRecognizer(viewTapGestureRecognizer)

        submitButton.setBackgroundImage(UIImage(predefined: .buttonBackground), for: .normal)
        submitButton.setTitle("Comment", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0)

    }

    private func addSubviews() {
        addSubview(contentTextField)
        addSubview(submitButton)
    }

    private func setupLayout() {
        contentTextField.layer.cornerRadius = 8.0
        contentTextField.layer.masksToBounds = true
        contentTextField.layer.borderColor = UIColor.lightGray.cgColor
        contentTextField.layer.borderWidth = 1.0
        contentTextField.font = UIFont.systemFont(ofSize: 30)

        contentTextField.topAnchor == topAnchor + 10
        contentTextField.centerXAnchor == centerXAnchor
        contentTextField.heightAnchor == heightAnchor * 0.45
        contentTextField.widthAnchor == widthAnchor * 0.95

        submitButton.widthAnchor == widthAnchor * 0.95
        submitButton.centerXAnchor == centerXAnchor
        buttonBottom = submitButton.bottomAnchor == bottomAnchor
    }

    func playKeyboardAnimation(height: CGFloat) {
        buttonBottom?.constant = -height
        layoutIfNeeded()
    }

    @objc private func hideKeyboard() {
        endEditing(true)
    }

    @objc private func didTapSubmitButton() {
        onSubmitButtonTapped?()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
