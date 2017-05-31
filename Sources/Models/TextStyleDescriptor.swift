//
//  Created by Jakub Turek on 31.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

struct TextStyleDescriptor {

    let font: Font
    let size: Double
    let color: Color

}

extension TextStyleDescriptor {

    func copy(with color: Color) -> TextStyleDescriptor {
        return TextStyleDescriptor(font: font, size: size, color: color)
    }

}

extension TextStyleDescriptor {

    var uiFont: UIFont {
        guard let uiFont = UIFont(name: font.rawValue, size: CGFloat(size)) else {
            fatalError("Could not create font with name \(font.rawValue) and size: \(size)")
        }

        return uiFont
    }

    var uiColor: UIColor {
        return UIColor(predefined: color)
    }

}
