@testable import ELDebateFramework
import Nimble
import Quick

class TextStyleDescriptorSpec: QuickSpec {

    override func spec() {
        var sizeCalculator: FontSizeCalculatorMock!
        var sut: TextStyleDescriptorFactory!

        describe("TextStyleDescriptorFactory") {
            beforeEach {
                sizeCalculator = FontSizeCalculatorMock()
                sut = TextStyleDescriptorFactory(sizeCalculator: sizeCalculator,
                                                 screenBounds: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 195.0))
            }

            describe("make") {
                describe("creating style for buttonTitle") {
                    var style: TextStyleDescriptor!

                    beforeEach {
                        style = sut.make(for: .buttonTitle)
                    }

                    it("should return a proper font size") {
                        expect(style.size) == 20.0
                    }

                    it("should return a medium font") {
                        expect(style.font.rawValue) == Font.medium.rawValue
                    }

                    it("should return button title color") {
                        expect(style.color.rawValue) == Color.buttonTitle.rawValue
                    }

                    it("should pass correct height to size calculator") {
                        expect(sizeCalculator.screenHeight) == 195.0
                    }
                }
            }
        }
    }

}
