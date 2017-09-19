@testable import ELDebateFramework
import UIKit
import PromiseKit

class AlertViewMock: AlertShowing {
    var wasShown: Bool = false
    var title: String?
    var message: String?

    @discardableResult func show(in controller: UIViewController, title: String, message: String) -> Promise<Bool> {
        self.title = title
        self.message = message
        wasShown = true
        return Promise(value: true)
    }
}
