//
//  Created by Jakub Turek on 26.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

extension UIView {

    func dropShadow() {
        let shadowRectangle = bounds.insetBy(dx: -1.0, dy: -1.0)
        let shadowPath = UIBezierPath(roundedRect: shadowRectangle, cornerRadius: layer.cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowOpacity = 0.4
        layer.shadowPath = shadowPath.cgPath
    }

}
