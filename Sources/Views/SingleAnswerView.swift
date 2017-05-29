//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class SingleAnswerView: UIView {

    let answerType: AnswerType
    private let container: UIView = UIView(frame: .zero)
    private let horizontalStack: UIStackView = Views.stack(axis: .horizontal, distribution: .fill,
                                                           alignment: .fill, spacing: 10.0)
    private let answerLabel: UILabel
    private let thumbsUp: ThumbsUpView
    private let highlightColor: UIColor
    private let defaultColor: UIColor = UIColor(predefined: .unselected)
    private let spinner: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    init(color: Color, type: AnswerType) {
        self.answerType = type
        self.highlightColor = UIColor(predefined: color)
        self.answerLabel = Views.label(size: 16.0, color: defaultColor, alignment: .left, numberOfLines: 0)
        self.thumbsUp = ThumbsUpView(highlightColor: color)

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    func setText(_ text: String) {
        answerLabel.text = text
    }

    func startSpinner() {
        spinner.startAnimating()
    }

    func stopSpinner() {
        spinner.stopAnimating()
    }

    var selected: Bool = false {
        didSet {
            thumbsUp.selected = selected
            answerLabel.textColor = selected ? highlightColor : defaultColor
        }
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
        container.dropShadow()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 5.0
    }

    private func addSubviews() {
        horizontalStack.addArrangedSubview(answerLabel)
        horizontalStack.addArrangedSubview(spinner)
        horizontalStack.addArrangedSubview(thumbsUp)

        container.addSubview(horizontalStack)
        addSubview(container)
    }

    // MARK: - Layout

    private func setUpLayout() {
        let insets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)

        container.edgeAnchors == edgeAnchors
        horizontalStack.edgeAnchors == container.edgeAnchors + insets

        answerLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        thumbsUp.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        spinner.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)

        thumbsUp.widthAnchor == thumbsUp.heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
