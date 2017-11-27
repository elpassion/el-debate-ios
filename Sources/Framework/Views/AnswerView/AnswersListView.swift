import Anchorage
import UIKit

class AnswersListView: UIView {

    private let stack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                 alignment: .fill, spacing: 15.0)
    private let chooseSideLabel: UILabel = Views.label(style: .description, numberOfLines: 0)
    private let answerPicker: AnswerPicker = AnswerPicker()
    private let changeMindLabel: UILabel = Views.label(style: .description, numberOfLines: 0)

    var onAnswerSelected: ((AnswerType) -> Void)? {
        get { return answerPicker.onAnswerSelected }
        set { answerPicker.onAnswerSelected = newValue }
    }

    var enabled: Bool {
        get { return answerPicker.enabled }
        set { answerPicker.enabled = newValue }
    }

    var selectedAnswer: AnswerType? {
        return answerPicker.selectedAnswer
    }

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: Public API

    func config(yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String) {
        answerPicker.config(yesAnswerText: yesAnswerText,
                            undecidedAnswerText: undecidedAnswerText,
                            noAnswerText: noAnswerText)
    }

    func selectAnswer(type answerType: AnswerType) {
        answerPicker.selectAnswer(type: answerType)
    }

    func stopSpinners() {
        answerPicker.stopSpinners()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        chooseSideLabel.text = "Choose your side with one of the following:"

        changeMindLabel.text = "Remember that you can change your mind before debate ends, thats why we are here!"
    }

    private func addSubviews() {
        stack.addArrangedSubview(chooseSideLabel)
        stack.addArrangedSubview(answerPicker)
        stack.addArrangedSubview(changeMindLabel)

        addSubview(stack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        stack.edgeAnchors == edgeAnchors
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
