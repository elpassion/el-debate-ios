//
//  Created by Jakub Turek on 31.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

class AttributedLabel: UILabel {

    private var attributes: AttributesDescriptor

    init(attributes: AttributesDescriptor) {
        self.attributes = attributes

        super.init(frame: .zero)
    }

    // MARK: - Text

    override var text: String? {
        get { return attributedText?.string }
        set { updateAttributedText(with: newValue) }
    }

    private func updateAttributedText(with text: String?) {
        attributedText = NSAttributedString(string: text ?? "",
                                            attributes: attributes.build())
    }

    // MARK: - Color

    var color: Color {
        get {
            return attributes.style.color
        }
        set {
            attributes = attributes.copy(with: newValue)
            updateAttributedText(with: text)
        }
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
