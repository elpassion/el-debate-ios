//
//  Created by Jakub Turek on 05.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

class FontSizeCalculatorMock: FontSizeCalculating {

    var screenHeight: Double?

    func size(withReferenceSize fontSize: Double, forScreenHeight screenHeight: Double) -> Double {
        self.screenHeight = screenHeight
        return fontSize
    }

}
