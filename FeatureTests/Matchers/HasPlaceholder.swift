import EarlGrey
import UIKit

func grey_hasPlaceholder(_ placeholder: String) -> GREYMatcher {
    let matcher: GREYElementMatcherBlock = GREYElementMatcherBlock(matchesBlock: { element in
        guard let textField = element as? UITextField else { return false }
        return textField.placeholder == placeholder
    }, descriptionBlock: { description in
        _ = description?.appendText("hasPlaceholder('\(placeholder)')'")
    })

    return grey_allOf([grey_kindOfClass(UITextField.self), matcher])
}
