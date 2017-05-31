//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class QuestionFrameView: UIView {

    private let container: UIView = UIView(frame: .zero)
    private let question: UILabel = Views.label(style: .question, numberOfLines: 0)

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    func setText(_ text: String) {
        question.text = text
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
        container.dropShadow()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 5.0
    }

    private func addSubviews() {
        container.addSubview(question)

        addSubview(container)
    }

    // MARK: - Layout

    private func setUpLayout() {
        container.edgeAnchors == edgeAnchors

        question.edgeAnchors == container.edgeAnchors + UIEdgeInsets(top: 20.0, left: 8.0, bottom: 20.0, right: 8.0)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
