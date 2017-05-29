//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import PromiseKit
import UIKit

class AnswerPicker: UIView {

    private let verticalStack = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                            alignment: .fill, spacing: 14.0)
    private let yesAnswer = SingleAnswerView(color: .yes, type: .positive)
    private let noAnswer = SingleAnswerView(color: .no, type: .negative)
    private let undecidedAnswer = SingleAnswerView(color: .undecided, type: .neutral)
    private let tapGestureRecognizer = UITapGestureRecognizer()

    var onAnswerSelected: ((AnswerType) -> Void)?

    private var answerViews: [SingleAnswerView] {
        return [yesAnswer, noAnswer, undecidedAnswer]
    }

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    // MARK: Public API

    func selectAnswer(type answerType: AnswerType) {
        answerViews.forEach { (view) in
            view.selected = view.answerType == answerType
        }
    }

    func config(yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String) {
        yesAnswer.setText(yesAnswerText)
        undecidedAnswer.setText(undecidedAnswerText)
        noAnswer.setText(noAnswerText)
    }

    func stopSpinners() {
        yesAnswer.stopSpinner()
        noAnswer.stopSpinner()
        undecidedAnswer.stopSpinner()
    }

    // MARK: - Subviews

    private func addSubviews() {
        verticalStack.addArrangedSubview(yesAnswer)
        verticalStack.addArrangedSubview(noAnswer)
        verticalStack.addArrangedSubview(undecidedAnswer)

        addSubview(verticalStack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        verticalStack.edgeAnchors == edgeAnchors

        yesAnswer.heightAnchor == 45
        noAnswer.heightAnchor == yesAnswer.heightAnchor
        undecidedAnswer.heightAnchor == noAnswer.heightAnchor
    }

    // MARK: - Gesture recognition

    private func setUpGestureRecognition() {
        tapGestureRecognizer.addTarget(self, action: #selector(didTapAnswer(with:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func didTapAnswer(with gestureRecognizer: UITapGestureRecognizer) {
        guard let answerView = tappedAnswerView(with: gestureRecognizer) else { return }
        if !answerView.selected {
            answerView.startSpinner()
            onAnswerSelected?(answerView.answerType)
        }
    }

    private func tappedAnswerView(with gestureRegognizer: UITapGestureRecognizer) -> SingleAnswerView? {
        let tapLocation = gestureRegognizer.location(in: self)

        return answerViews.filter { $0.frame.contains(tapLocation) }.first
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
