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

enum TextStyle {

    case answer
    case description
    case question
    case welcome

}

extension TextStyle {

    var style: TextStyleDescriptor {
        switch self {
        case .answer:
            return TextStyleDescriptor(font: .regular, size: 18.0, color: .undecided)
        case .description:
            return TextStyleDescriptor(font: .regular, size: 12.0, color: .description)
        case .question:
            return TextStyleDescriptor(font: .medium, size: 18.0, color: .question)
        case .welcome:
            return TextStyleDescriptor(font: .regular, size: 20.0, color: .question)
        }
    }

    var font: UIFont {
        guard let font = UIFont(name: style.font.rawValue, size: CGFloat(style.size)) else {
            fatalError("Could not create font with name \(style.font.rawValue) and size: \(style.size)")
        }

        return font
    }

    var color: UIColor {
        return UIColor(predefined: style.color)
    }

}
