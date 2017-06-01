//
//  Created by Jakub Turek on 31.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

enum TextStyle {

    case answer
    case description
    case question
    case welcome
    case buttonTitle
    case enterPin

}

extension TextStyle {

    var style: TextStyleDescriptor {
        switch self {
        case .answer:
            return TextStyleDescriptor(font: .regular, size: 18.0, color: .undecided)
        case .description:
            return TextStyleDescriptor(font: .regular, size: 10.0, color: .description)
        case .question:
            return TextStyleDescriptor(font: .medium, size: 19.0, color: .question)
        case .welcome:
            return TextStyleDescriptor(font: .regular, size: 20.0, color: .question)
        case .buttonTitle:
            return TextStyleDescriptor(font: .medium, size: 18.0, color: .buttonTitle)
        case .enterPin:
            return TextStyleDescriptor(font: .regular, size: 18.0, color: .pin)
        }
    }

    var font: UIFont {
        return style.uiFont
    }

    var color: UIColor {
        return style.uiColor
    }

}
