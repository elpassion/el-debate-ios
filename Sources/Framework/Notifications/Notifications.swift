struct TypedNotification {

    static let keyboardWillShow: NotificationDescriptor =
        NotificationDescriptor(name: UIResponder.keyboardWillShowNotification, parser: KeyboardWillShowPayload.init)

    static let keyboardWillHide: NotificationDescriptor =
        NotificationDescriptor(name: UIResponder.keyboardWillHideNotification, parser: KeyboardWillShowPayload.init)
}
