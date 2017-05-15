//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerView: UIView {

    private let scrollView = UIScrollView(frame: .zero)
    private let verticalStack = Views.stack(axis: .vertical, distribution: .equalSpacing, alignment: .fill,
                                            spacing: 10.0)
    private let aboutLabel = Views.label(size: 16.0, color: UIColor(predefined: .pin), alignment: .left,
                                         numberOfLines: 0)
    private let questionView = QuestionView()
    private let chooseSideLabel = Views.label(size: 16.0, color: UIColor(predefined: .pin), alignment: .left,
                                              numberOfLines: 0)
    private let answerOptionsView = AnswerOptionsView()
    private let changeMindLabel = Views.label(size: 16.0, color: UIColor(predefined: .pin), alignment: .left,
                                              numberOfLines: 0)
    private let background = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)

        aboutLabel.text = "Our debate at is about:"

        chooseSideLabel.text = "Choose your side with one of the following:"

        changeMindLabel.text = "Remember that you can change your mind before debate ends, thats why we are here!"
    }

    private func addSubviews() {
        verticalStack.addArrangedSubview(aboutLabel)
        verticalStack.addArrangedSubview(questionView)
        verticalStack.addArrangedSubview(chooseSideLabel)
        verticalStack.addArrangedSubview(answerOptionsView)
        verticalStack.addArrangedSubview(changeMindLabel)

        scrollView.addSubview(verticalStack)

        addSubview(background)
        addSubview(scrollView)
    }

    // MARK: - Layout

    private func setUpLayout() {
        let stackInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)

        scrollView.edgeAnchors == edgeAnchors

        verticalStack.edgeAnchors == scrollView.edgeAnchors + stackInsets
        verticalStack.widthAnchor == widthAnchor - stackInsets.left - stackInsets.right

        background.centerXAnchor == centerXAnchor
        background.bottomAnchor == bottomAnchor - 20
        background.widthAnchor == widthAnchor * 0.95
        background.heightAnchor == background.widthAnchor * 0.75
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
