@testable import ELDebateFramework
import UIKit

class KeyboardWillShowHandlerMock: KeyboardWillShowHandling {

    var onKeyboardHeightChanged: ((CGFloat) -> Void)?

}
