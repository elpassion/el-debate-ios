//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerPicker: UIView {

    private let verticalStack = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                            alignment: .fill, spacing: 14.0)
    private let yesAnswer = SingleAnswerView(color: .yes, type: .positive)
    private let noAnswer = SingleAnswerView(color: .no, type: .negative)
    private let undecidedAnswer = SingleAnswerView(color: .undecided, type: .neutral)
    private let tapGestureRecognizer = UITapGestureRecognizer()

    var onAnswerSelected: ((AnswerType) -> Void)?

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    func config(yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String) {
        yesAnswer.setText(yesAnswerText)
        undecidedAnswer.setText(undecidedAnswerText)
        noAnswer.setText(noAnswerText)
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
        guard let answer = tappedAnswerView(with: gestureRecognizer) else { return }

        onAnswerSelected?(answer.answerType)
        updateSelection(with: answer)
    }

    private func updateSelection(with view: SingleAnswerView) {
        [yesAnswer, noAnswer, undecidedAnswer].forEach { $0.selected = $0 == view }
    }

    private func tappedAnswerView(with gestureRegognizer: UITapGestureRecognizer) -> SingleAnswerView? {
        let views: [SingleAnswerView] = [yesAnswer, noAnswer, undecidedAnswer]
        let tapLocation = gestureRegognizer.location(in: self)

        return views.filter { $0.frame.contains(tapLocation) }.first
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
