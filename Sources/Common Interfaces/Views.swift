//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

struct Views {

    static func stack(axis: UILayoutConstraintAxis, distribution: UIStackViewDistribution,
                      alignment: UIStackViewAlignment, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = alignment
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing

        return stackView
    }

    static func label(style: AttributeStyle, numberOfLines: Int, text: String? = nil) -> AttributedLabel {
        let label = AttributedLabel(attributes: style.attributes)
        label.lineBreakMode = numberOfLines > 0 ? .byWordWrapping : .byTruncatingTail
        label.numberOfLines = numberOfLines
        label.text = text

        return label
    }

    static func image(image: Image, contentMode: UIViewContentMode,
                      renderingMode: UIImageRenderingMode? = nil) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = contentMode
        imageView.image = UIImage(predefined: image).flatMap { (image) in
            image.withRenderingMode(renderingMode ?? .alwaysOriginal)
        }

        return imageView
    }

    static func button(style: TextStyle, backgroundColor: Color, cornerRadius: CGFloat,
                       title: String? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(predefined: backgroundColor)
        button.layer.cornerRadius = cornerRadius
        button.setTitle(title, for: .normal)
        button.setTitleColor(style.color, for: .normal)
        button.titleLabel?.font = style.font

        return button
    }

}
