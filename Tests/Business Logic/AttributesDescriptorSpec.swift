@testable import ELDebateFramework
import Nimble
import Quick
import UIColor_Hex_Swift
import UIKit

class AttributesDescriptorSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("AttributesDescriptor") {
            var textStyle: TextStyleDescriptor!
            var sut: AttributesDescriptor!

            beforeEach {
                textStyle = TextStyleDescriptor(font: .regular, size: 16.0, color: .pin)
                sut = AttributesDescriptor(style: textStyle, alignment: .justified, lineSpacing: 20.0, kern: 4.0)
            }

            describe("build") {
                var attributes: [NSAttributedStringKey: AnyObject]!

                beforeEach {
                    attributes = sut.build()
                }

                it("should have correct line spacing set") {
                    let paragraphStyle = attributes[NSAttributedStringKey.paragraphStyle] as? NSParagraphStyle

                    expect(paragraphStyle?.lineSpacing) == CGFloat(20.0)
                }

                it("should have correct alignment set") {
                    let paragraphStyle = attributes[NSAttributedStringKey.paragraphStyle] as? NSParagraphStyle

                    expect(paragraphStyle?.alignment) == NSTextAlignment.justified
                }

                it("should have correct font name set") {
                    let font = attributes[NSAttributedStringKey.font] as? UIFont

                    expect(font?.fontName) == Font.regular.rawValue
                }

                it("should have correct font size set") {
                    let font = attributes[NSAttributedStringKey.font] as? UIFont

                    expect(font?.pointSize) == CGFloat(16.0)
                }

                it("should have correct kern set") {
                    let kern = attributes[NSAttributedStringKey.kern] as? NSNumber

                    expect(kern) == NSNumber(value: 4.0)
                }

                it("should have correct foreground color set") {
                    let color = attributes[NSAttributedStringKey.foregroundColor] as? UIColor

                    expect(color?.hexString()) == UIColor(predefined: .pin).hexString()
                }
            }

            describe("copy with color") {
                var copy: AttributesDescriptor!

                beforeEach {
                    copy = sut.copy(with: .yes)
                }

                it("should be a different instance") {
                    expect(copy).toNot(be(sut))
                }

                it("should have the same font") {
                    expect(copy.style.font) == Font.regular
                    expect(copy.style.size) == 16.0
                }

                it("should have yes text style color") {
                    expect(copy.style.color.rawValue) == Color.yes.rawValue
                }

                it("should have the same kern") {
                    expect(copy.kern) == sut.kern
                }

                it("should have the same alignment") {
                    expect(copy.alignment) == sut.alignment
                }

                it("should have the same line spacing") {
                    expect(copy.lineSpacing) == sut.lineSpacing
                }
            }
        }
    }

}
