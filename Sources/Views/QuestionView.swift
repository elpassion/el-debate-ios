//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class QuestionView: UIView {

    private let container = UIView(frame: .zero)
    private let question = Views.label(size: 24.0, color: UIColor(predefined: .question),
                                       alignment: .center, numberOfLines: 0,
                                       text: "Lorem ipsum dolor sit amet consectetur?")

    init() {
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

        question.edgeAnchors == edgeAnchors + UIEdgeInsets(top: 25.0, left: 15.0, bottom: 25.0, right: 15.0)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
