//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class SingleAnswerView: UIView {

    private let container = UIView(frame: .zero)
    private let horizontalStack = Views.stack(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 10.0)
    private let answerLabel: UILabel
    private let thumbsUp: ThumbsUpView

    init(color: UIColor, text: String) {
        self.answerLabel = Views.label(size: 16.0, color: color, alignment: .left, numberOfLines: 0, text: text)
        self.thumbsUp = ThumbsUpView(highlightColor: color)

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
        makeDropShadow()
    }

    private func makeDropShadow() {
        let shadowRectangle = container.bounds.insetBy(dx: -1.0, dy: -1.0)
        let shadowPath = UIBezierPath(roundedRect: shadowRectangle, cornerRadius: container.layer.cornerRadius)

        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        container.layer.shadowOpacity = 0.4
        container.layer.shadowPath = shadowPath.cgPath
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        container.backgroundColor = .white
        container.layer.cornerRadius = 5.0
    }

    private func addSubviews() {
        horizontalStack.addArrangedSubview(answerLabel)
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

        thumbsUp.widthAnchor == thumbsUp.heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
