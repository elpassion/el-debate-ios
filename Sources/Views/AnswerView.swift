//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

protocol AnswerViewProviding {
    func config(debateTitle: String, yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String)
}

class AnswerView: UIView, AnswerViewProviding {

    private let scrollView = UIScrollView(frame: .zero)
    private let verticalStack = Views.stack(axis: .vertical, distribution: .equalSpacing, alignment: .fill,
                                            spacing: 30.0)
    private let questionView = QuestionView()
    private let answersListView = AnswersListView()
    private let background = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
    private let commentButton = UIButton(type: .custom)

    var onCommentButtonTapped: (() -> Void)?

    var onAnswerSelected: ((AnswerType) -> Void)? {
        get {
           return answersListView.onAnswerSelected
        }

        set {
            answersListView.onAnswerSelected = newValue
        }
    }

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: Public API

    func config(debateTitle: String, yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String) {
        questionView.setText(debateTitle)
        answersListView.config(
            yesAnswerText: yesAnswerText,
            undecidedAnswerText: undecidedAnswerText,
            noAnswerText: noAnswerText
        )
    }

    func selectAnswer(type answerType: AnswerType) {
        answersListView.selectAnswer(type: answerType)
    }

    func stopSpinners() {
        answersListView.stopSpinners()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)

        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        commentButton.setBackgroundImage(UIImage(predefined: .buttonBackground), for: .normal)
        commentButton.setTitle("Comment", for: .normal)
        commentButton.setTitleColor(.white, for: .normal)
        commentButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0)
    }

    private func addSubviews() {
        verticalStack.addArrangedSubview(questionView)
        verticalStack.addArrangedSubview(answersListView)

        scrollView.addSubview(verticalStack)

        addSubview(background)
        addSubview(scrollView)
        addSubview(commentButton)
    }

    // MARK: - Comment button tap

    @objc private func didTapCommentButton() {
        onCommentButtonTapped?()
    }

    // MARK: - Layout

    private func setUpLayout() {
        let stackInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0)

        scrollView.edgeAnchors == edgeAnchors

        verticalStack.edgeAnchors == scrollView.edgeAnchors + stackInsets
        verticalStack.widthAnchor == widthAnchor - stackInsets.left - stackInsets.right

        background.centerXAnchor == centerXAnchor
        background.bottomAnchor == bottomAnchor - 20
        background.widthAnchor == widthAnchor * 0.95
        background.heightAnchor == background.widthAnchor * 0.75

        commentButton.centerXAnchor == centerXAnchor
        commentButton.bottomAnchor == bottomAnchor - 15
        commentButton.widthAnchor == widthAnchor * 0.9
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
