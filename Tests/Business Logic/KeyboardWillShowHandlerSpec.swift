@testable import ELDebateFramework
import Foundation
import Nimble
import Quick

class KeyboardWillShowHandlerSpec: QuickSpec {

    override func spec() {
        var notificationManager: NotificationManagingMock!
        var sut: KeyboardWillShowHandler!

        describe("KeyboardWillShowHandler") {
            beforeEach {
                notificationManager = NotificationManagingMock()
                sut = KeyboardWillShowHandler(notificationManager: notificationManager)
            }

            afterEach {
                sut = nil
            }

            describe("initializer") {
                it("should register sut to keyboard will show notification") {
                    expect(notificationManager.observedNotifications).to(containElementSatisfying({ notification in
                        notification == Notification.Name.UIKeyboardWillShow
                    }))
                }

                it("should register sut to keyboard will hide notification") {
                    expect(notificationManager.observedNotifications).to(containElementSatisfying({ notification in
                        notification == Notification.Name.UIKeyboardWillHide
                    }))
                }
            }

            describe("deinitializer") {
                it("should remove sut from notification observers pool") {
                    sut = nil

                    expect(notificationManager.removedObserver).toEventually(beTrue())
                }
            }

            describe("keyboard change handler callback") {
                var keyboardHeight: CGFloat?

                beforeEach {
                    keyboardHeight = nil
                    sut.onKeyboardHeightChanged = { keyboardHeight = $0 }
                }

                it("should be triggered with keyboard height when keyboard shows") {
                    let notification = Notification(name: .UIKeyboardWillShow,
                                                    object: nil,
                                                    userInfo: keyboardUserInfo(height: 200.0))

                    notificationManager.callbacks[Notification.Name.UIKeyboardWillShow]?(notification)

                    expect(keyboardHeight).toEventually(equal(CGFloat(200.0)))
                }

                it("should be triggered with zero when keyboard hides") {
                    let notification = Notification(name: .UIKeyboardWillHide,
                                                    object: nil,
                                                    userInfo: keyboardUserInfo(height: 200.0))

                    notificationManager.callbacks[Notification.Name.UIKeyboardWillHide]?(notification)

                    expect(keyboardHeight).toEventually(equal(CGFloat(0.0)))
                }
            }
        }
    }

}

private func keyboardUserInfo(height: CGFloat) -> [AnyHashable: Any] {
    let keyboardRectangle = NSValue(cgRect: CGRect(x: 0.0, y: 0.0, width: 300.0, height: height))
    let userInfo: [AnyHashable: Any] = ["UIKeyboardFrameEndUserInfoKey": keyboardRectangle]

    return userInfo
}
