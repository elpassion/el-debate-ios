//
//  Created by Jakub Turek on 05.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol FontSizeCalculating: AutoMockable {

    func size(withReferenceSize fontSize: Double, forScreenHeight screenHeight: Double) -> Double

}

class FontSizeCalculator: FontSizeCalculating {

    private let referenceHeight: Double = 667.0

    func size(withReferenceSize fontSize: Double, forScreenHeight screenHeight: Double) -> Double {
        let scale = screenHeight / referenceHeight
        return round(fontSize * scale)
    }

}
