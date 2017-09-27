import UIColor_Hex_Swift
import UIKit

extension UIColor {

    convenience init(predefined: Color) {
        self.init(predefined.rawValue)
    }

}
