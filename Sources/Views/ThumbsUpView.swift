//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class ThumbsUpView: UIView {

    private let thumbsUpIcon = Views.image(image: .thumbsUp, contentMode: .scaleAspectFit)
    private let highlightColor: UIColor

    init(highlightColor: UIColor) {
        self.highlightColor = highlightColor

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Layout subviews (corner radius)

    override func layoutSubviews() {
        super.layoutSubviews()
        makeOval()
    }

    private func makeOval() {
        layer.cornerRadius = min(frame.size.width, frame.size.height) * 0.5
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        backgroundColor = highlightColor
    }

    private func addSubviews() {
        addSubview(thumbsUpIcon)
    }

    // MARK: - Layout

    private func setUpLayout() {
        thumbsUpIcon.edgeAnchors == self.edgeAnchors + UIEdgeInsets(top: 7, left: 9, bottom: 10, right: 9)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
