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
