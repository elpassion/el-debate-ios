import UIKit

enum Color: String {

    case screenBackground = "#F8FAF8"
    case navigationBar = "#4CC359"
    case pin = "#C0C0C0"
    case question = "#4A4A4A"
    case unselected = "#EAEAEA"
    case positiveTint = "#0098E3"
    case negativeTint = "#E44043"
    case undecidedTint = "#8F8F8F"
    case description = "#B8B8B8"
    case buttonTitle = "#FFFFFF"
    case highlightedButton = "#5DC869"

}

extension Color {

    var ui: UIColor {
        return UIColor(predefined: self)
    }

}
