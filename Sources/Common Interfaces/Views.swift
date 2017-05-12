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

    static func label(size: CGFloat, color: UIColor, alignment: NSTextAlignment, numberOfLines: Int,
                      text: String? = nil) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: size)
        label.lineBreakMode = numberOfLines > 0 ? .byWordWrapping : .byTruncatingTail
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        label.textColor = color
        label.text = text

        return label
    }

    static func image(image: Image, contentMode: UIViewContentMode) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = contentMode
        imageView.image = UIImage(predefined: image)

        return imageView
    }

}
