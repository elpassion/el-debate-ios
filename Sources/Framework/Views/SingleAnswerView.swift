import Anchorage
import UIKit

class SingleAnswerView: UIView {

    let answerType: AnswerType

    private let container: UIView = UIView(frame: .zero)
    private let stackContainer: UIView = UIView(frame: .zero)
    private let horizontalStack: UIStackView = Views.stack(axis: .horizontal, distribution: .fill,
                                                           alignment: .center, spacing: 10.0)
    private let answerLabel: AttributedLabel
    private let iconView: UIImageView
    private let highlightColor: Color
    private let defaultColor: Color = .unselected
    private let progressView: ProgressView

    init(color: Color, image: Image, type: AnswerType) {
        self.answerType = type
        self.highlightColor = color
        self.answerLabel = Views.label(style: .answer, numberOfLines: 0)
        self.iconView = Views.image(image: image, contentMode: .scaleAspectFit, renderingMode: .alwaysTemplate)
        self.progressView = ProgressView(color: color)

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
        container.dropShadow()
    }

    // MARK: - Public API

    func setText(_ text: String) {
        answerLabel.text = text
    }

    func startSpinner() {
        progressView.startAnimation()
    }

    func stopSpinner() {
        progressView.stopAnimation()
    }

    var selected: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.iconView.tintColor = self.selected ? self.highlightColor.ui : self.defaultColor.ui
            }
        }
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 5.0

        stackContainer.backgroundColor = .white
        stackContainer.clipsToBounds = true
        stackContainer.layer.cornerRadius = container.layer.cornerRadius

        iconView.tintColor = defaultColor.ui

        answerLabel.color = highlightColor
    }

    private func addSubviews() {
        horizontalStack.addArrangedSubview(answerLabel)
        horizontalStack.addArrangedSubview(iconView)

        stackContainer.addSubview(horizontalStack)
        stackContainer.addSubview(progressView)

        container.addSubview(stackContainer)

        addSubview(container)
    }

    // MARK: - Layout

    private func setUpLayout() {
        let insets = UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)

        container.edgeAnchors == edgeAnchors
        stackContainer.edgeAnchors == container.edgeAnchors
        horizontalStack.edgeAnchors == container.edgeAnchors + insets

        answerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        iconView.setContentHuggingPriority(.required, for: .horizontal)

        answerLabel.heightAnchor == horizontalStack.heightAnchor

        iconView.heightAnchor == container.heightAnchor * 0.55
        iconView.widthAnchor == iconView.heightAnchor

        progressView.leadingAnchor == stackContainer.leadingAnchor
        progressView.bottomAnchor == stackContainer.bottomAnchor
        progressView.heightAnchor == 2.0
        progressView.widthAnchor == stackContainer.widthAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
