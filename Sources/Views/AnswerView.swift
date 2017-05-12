//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerView: UIView {

    private let verticalStack = Views.stack(axis: .vertical, distribution: .fill, alignment: .fill, spacing: 10.0)
    private let aboutLabel = Views.label(size: 16.0, color: UIColor(predefined: .pin), alignment: .left,
                                         numberOfLines: 0, text: "Our debate at 24.03.2017 is about:")
    private let answerOptionsView = AnswerOptionsView()
    private let chooseSideLabel = Views.label(size: 16.0, color: UIColor(predefined: .pin), alignment: .left,
                                              numberOfLines: 0, text: "Choose your side with one of the following:")

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)
    }

    private func addSubviews() {
        verticalStack.addArrangedSubview(aboutLabel)
        verticalStack.addArrangedSubview(answerOptionsView)
        verticalStack.addArrangedSubview(chooseSideLabel)

        addSubview(verticalStack)
    }

    // MARK: - Layout

    private func setUpLayout() {
        verticalStack.edgeAnchors == edgeAnchors + UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
