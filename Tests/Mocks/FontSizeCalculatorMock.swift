@testable import ELDebateFramework

class FontSizeCalculatorMock: FontSizeCalculating {

    var screenHeight: Double?

    func size(withReferenceSize fontSize: Double, forScreenHeight screenHeight: Double) -> Double {
        self.screenHeight = screenHeight
        return fontSize
    }

}
