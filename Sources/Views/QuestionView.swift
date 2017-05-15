//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class QuestionView: UIView {

    private let stack = Views.stack(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 10.0)
    private let title = Views.label(size: 13.0, color: UIColor(predefined: .pin), alignment: .left, numberOfLines: 0)
    private let questionFrame = QuestionFrameView()

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
        title.text = "Our debate at is about:"
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

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
