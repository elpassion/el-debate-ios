//
//  Created by Jakub Turek on 26.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

struct TypedNotification {

    static let keyboardWillShow: NotificationDescriptor =
        NotificationDescriptor(name: .UIKeyboardWillShow, parser: KeyboardWillShowPayload.init)

    static let keyboardWillHide: NotificationDescriptor =
        NotificationDescriptor(name: .UIKeyboardWillHide, parser: KeyboardWillShowPayload.init)
}
