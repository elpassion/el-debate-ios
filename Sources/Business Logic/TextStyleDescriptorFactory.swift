//
//  Created by Jakub Turek on 05.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

protocol TextStyleDescriptorCreating {

    func make(for style: TextStyle) -> TextStyleDescriptor

}

class TextStyleDescriptorFactory: TextStyleDescriptorCreating {

    private let sizeCalculator: FontSizeCalculating
    private let screenBounds: CGRect

    init(sizeCalculator: FontSizeCalculating, screenBounds: CGRect) {
        self.sizeCalculator = sizeCalculator
        self.screenBounds = screenBounds
    }

    func make(for style: TextStyle) -> TextStyleDescriptor {
        switch style {
        case .answer:
            return TextStyleDescriptor(font: .regular, size: size(24.0), color: .undecided)
        case .description:
            return TextStyleDescriptor(font: .regular, size: size(12.0), color: .description)
        case .question:
            return TextStyleDescriptor(font: .medium, size: size(24.0), color: .question)
        case .welcome:
            return TextStyleDescriptor(font: .regular, size: size(20.0), color: .question)
        case .buttonTitle:
            return TextStyleDescriptor(font: .medium, size: size(20.0), color: .buttonTitle)
        case .enterPin:
            return TextStyleDescriptor(font: .regular, size: size(20.0), color: .pin)
        }
    }

    private func size(_ referenceSize: Double) -> Double {
        return sizeCalculator.size(withReferenceSize: referenceSize,
                                   forScreenHeight: Double(screenBounds.height))
    }

}

class StyleBuilder {

    static let factory: TextStyleDescriptorCreating = TextStyleDescriptorFactory(
        sizeCalculator: FontSizeCalculator(), screenBounds: UIScreen.main.bounds)

    class func build(for style: TextStyle) -> TextStyleDescriptor {
        return factory.make(for: style)
    }

}
