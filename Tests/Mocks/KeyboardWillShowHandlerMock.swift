//
//  Created by Jakub Turek on 29.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import UIKit

class KeyboardWillShowHandlerMock: KeyboardWillShowHandling {

    var onKeyboardHeightChanged: ((CGFloat) -> Void)?

}
