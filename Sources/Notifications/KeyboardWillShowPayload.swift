//
//  Created by Jakub Turek on 26.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

struct KeyboardWillShowPayload {

    let height: CGFloat

    init?(userInfo: [AnyHashable: Any]) {
        guard let frame = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue else {
            return nil
        }

        self.height = frame.size.height
    }

}
