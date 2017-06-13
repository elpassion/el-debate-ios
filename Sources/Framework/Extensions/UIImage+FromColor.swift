//
//  Created by Jakub Turek on 08.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

extension UIImage {

    static func from(color: Color) -> UIImage? {
        let rectangle = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rectangle.size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.setFillColor(UIColor(predefined: color).cgColor)
        context.fill(rectangle)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }

        UIGraphicsEndImageContext()
        return image
    }

}
