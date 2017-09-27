struct TypedNotification {

    static let keyboardWillShow: NotificationDescriptor =
        NotificationDescriptor(name: .UIKeyboardWillShow, parser: KeyboardWillShowPayload.init)

    static let keyboardWillHide: NotificationDescriptor =
        NotificationDescriptor(name: .UIKeyboardWillHide, parser: KeyboardWillShowPayload.init)
}
