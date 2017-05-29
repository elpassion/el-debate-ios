//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class ThumbsUpView: UIView {

    private let thumbsUpIcon = Views.image(image: .thumbsUp, contentMode: .scaleAspectFit)
    private let highlightColor: UIColor
    private let defaultColor: UIColor

    init(highlightColor: Color) {
        self.highlightColor = UIColor(predefined: highlightColor)
        self.defaultColor = UIColor(predefined: .unselected)

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Public API

    var selected: Bool = false {
        didSet {
            backgroundColor = selected ? highlightColor : defaultColor
        }
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
        backgroundColor = defaultColor
    }

    private func addSubviews() {
        addSubview(thumbsUpIcon)
    }

    // MARK: - Layout

    private func setUpLayout() {
        thumbsUpIcon.edgeAnchors == self.edgeAnchors + UIEdgeInsets(top: 5, left: 5, bottom: 9, right: 5)
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
