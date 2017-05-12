//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIColor_Hex_Swift
import UIKit

extension UIColor {

    convenience init(predefined: Color) {
        self.init(predefined.rawValue)
    }

}
