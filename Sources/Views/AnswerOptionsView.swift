//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerOptionsView: UIView {

    private let verticalStack = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                            alignment: .fill, spacing: 20.0)
    private let yesAnswer = SingleAnswerView()
    private let noAnswer = SingleAnswerView()
    private let maybeAnswer = SingleAnswerView()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        verticalStack.addArrangedSubview(yesAnswer)
        verticalStack.addArrangedSubview(noAnswer)
        verticalStack.addArrangedSubview(maybeAnswer)

        addSubview(verticalStack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        verticalStack.edgeAnchors == edgeAnchors

        yesAnswer.heightAnchor == 50
        noAnswer.heightAnchor == yesAnswer.heightAnchor
        maybeAnswer.heightAnchor == noAnswer.heightAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
