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
