import UIKit

enum TextStyle {

    case answer
    case description
    case question
    case welcome
    case buttonTitle
    case enterPin
    case userName
    case commentBody
    case commentDate

}

extension TextStyle {

    var font: UIFont {
        return StyleBuilder.build(for: self).uiFont
    }

    var color: UIColor {
        return StyleBuilder.build(for: self).uiColor
    }

}
