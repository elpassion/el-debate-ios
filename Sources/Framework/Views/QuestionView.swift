import Anchorage
import UIKit

class QuestionView: UIView {

    private let stack: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                 alignment: .fill, spacing: 15.0)
    private let title: UILabel = Views.label(style: .description, numberOfLines: 0)
    private let questionFrame: QuestionFrameView = QuestionFrameView()

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    func setText(_ text: String) {
        questionFrame.setText(text)
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        title.text = "Our debate is about:"
    }

    private func addSubviews() {
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(questionFrame)

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
