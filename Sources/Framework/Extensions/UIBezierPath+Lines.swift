//
//  Created by Jakub Turek on 08.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

extension UIBezierPath {

    static func horizontalLine(from startingPoint: CGFloat, to endingPoint: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startingPoint, y: 0.0))
        path.addLine(to: CGPoint(x: endingPoint, y: 0.0))

        return path
    }

}
