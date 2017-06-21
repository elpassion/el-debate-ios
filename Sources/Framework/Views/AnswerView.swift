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

    private let scrollView: UIScrollView = UIScrollView(frame: .zero)
    private let verticalStack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                         alignment: .fill, spacing: 20.0)
    private let questionView: QuestionView = QuestionView()
    private let answersListView: AnswersListView = AnswersListView()
    private let background: UIImageView = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
    private let chatButton: ChatButtonView = ChatButtonView()

    var onChatButtonTapped: (() -> Void)? {
        get { return chatButton.onChatButtonTapped }
        set { chatButton.onChatButtonTapped = newValue }
    }

    var onAnswerSelected: ((AnswerType) -> Void)? {
        get { return answersListView.onAnswerSelected }
        set { answersListView.onAnswerSelected = newValue }
    }

    var enabled: Bool {
        get { return answersListView.enabled }
        set { answersListView.enabled = newValue }
    }

    var selectedAnswer: AnswerType? {
        return answersListView.selectedAnswer
    }

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        chatButton.dropShadow()
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

    func cancelAnimations() {
        answersListView.stopSpinners()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)
    }

    private func addSubviews() {
        verticalStack.addArrangedSubview(questionView)
        verticalStack.addArrangedSubview(answersListView)
        verticalStack.addArrangedSubview(chatButton)

        scrollView.addSubview(verticalStack)

        addSubview(background)
        addSubview(scrollView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        let stackInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 9.0, right: 20.0)

        scrollView.edgeAnchors == edgeAnchors

        verticalStack.edgeAnchors == scrollView.edgeAnchors + stackInsets
        verticalStack.widthAnchor == (widthAnchor - stackInsets.left - stackInsets.right) ~ .custom(999)

        background.centerXAnchor == centerXAnchor
        background.bottomAnchor == bottomAnchor - 20
        background.widthAnchor == widthAnchor * 0.95
        background.heightAnchor == background.widthAnchor * 0.75
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
