//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import PromiseKit
import UIKit

public class AnswerPicker: UIView {

    private let verticalStack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                         alignment: .fill, spacing: 14.0)
    private let yesAnswer: SingleAnswerView = SingleAnswerView(color: .yes, image: .thumbsUp, type: .positive)
    private let noAnswer: SingleAnswerView = SingleAnswerView(color: .no, image: .thumbsDown, type: .negative)
    private let undecidedAnswer: SingleAnswerView = SingleAnswerView(color: .undecided, image: .handNeutral,
                                                                     type: .neutral)
    private let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()

    var onAnswerSelected: ((AnswerType) -> Void)?
    var enabled: Bool = true

    var selectedAnswer: AnswerType? {
        let selectedView = answerViews.first { $0.selected }
        return selectedView?.answerType
    }

    private var answerViews: [SingleAnswerView] {
        return [yesAnswer, noAnswer, undecidedAnswer]
    }

    public init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
        setUpGestureRecognition()
    }

    // MARK: - Public API

    func selectAnswer(type answerType: AnswerType) {
        answerViews.forEach { view in
            view.selected = view.answerType == answerType
        }
    }

    func config(yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String) {
        yesAnswer.setText(yesAnswerText)
        undecidedAnswer.setText(undecidedAnswerText)
        noAnswer.setText(noAnswerText)
    }

    func stopSpinners() {
        answerViews.forEach { view in
            view.stopSpinner()
        }
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

        yesAnswer.heightAnchor == answerHeight
        noAnswer.heightAnchor == yesAnswer.heightAnchor
        undecidedAnswer.heightAnchor == noAnswer.heightAnchor
    }

    private var answerHeight: Double {
        return FontSizeCalculator().size(withReferenceSize: 60.0,
                                         forScreenHeight: Double(Display.height))
    }

    // MARK: - Gesture recognition

    private func setUpGestureRecognition() {
        tapGestureRecognizer.addTarget(self, action: #selector(didTapAnswer(with:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    private func didTapAnswer(with gestureRecognizer: UITapGestureRecognizer) {
        guard enabled else {
            return
        }

        guard let answerView = tappedAnswerView(with: gestureRecognizer), !answerView.selected else {
            return
        }

        answerView.startSpinner()
        onAnswerSelected?(answerView.answerType)
    }

    private func tappedAnswerView(with gestureRecognizer: UITapGestureRecognizer) -> SingleAnswerView? {
        let tapLocation = gestureRecognizer.location(in: self)

        return answerViews.first {
            $0.frame.contains(tapLocation)
        }
    }

    // MARK: - Required initializer

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
