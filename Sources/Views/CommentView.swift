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
    private let verticalStack = Views.stack(axis: .vertical, distribution: .equalSpacing, alignment: .fill,
                                              spacing: 20.0)
    private let viewTapGestureRecognizer = UITapGestureRecognizer()

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
        verticalStack.addArrangedSubview(contentTextField)
        verticalStack.addArrangedSubview(submitButton)
        addSubview(verticalStack)
    }

    private func setupLayout() {
        contentTextField.layer.cornerRadius = 8.0
        contentTextField.layer.masksToBounds = true
        contentTextField.layer.borderColor = UIColor.lightGray.cgColor
        contentTextField.layer.borderWidth = 1.0
        contentTextField.font = UIFont.systemFont(ofSize: 35)

        verticalStack.edgeAnchors == edgeAnchors
        verticalStack.widthAnchor == widthAnchor
        contentTextField.heightAnchor == verticalStack.heightAnchor * 0.5
    }

    @objc private func hideKeyboard() {
        endEditing(true)
    }

    @objc private func didTapSubmitButton() {
        onSubmitButtonTapped?()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
