import Anchorage
import UIKit

protocol NewCommentControllerProtocol {
    func attachTo(toolbar: NewCommentToolbar, viewController: UIViewController)
    func detachFrom(toolbar: NewCommentToolbar, viewController: UIViewController)
}

class NewCommentController: NSObject, NewCommentControllerProtocol, UITextFieldDelegate {
    private let service: NewCommentServiceProtocol
    private let repository: UserInfoRepository

    var toolbar: NewCommentToolbar?
    weak var viewController: UIViewController?

    init(newCommentService: NewCommentServiceProtocol, repository: UserInfoRepository) {
        self.service = newCommentService
        self.repository = repository
    }

    func attachTo(toolbar: NewCommentToolbar, viewController: UIViewController) {
        self.toolbar = toolbar
        self.viewController = viewController
        toolbar.button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        toolbar.textField.delegate = self
    }

    func detachFrom(toolbar: NewCommentToolbar, viewController: UIViewController) {
        self.toolbar = nil
        self.viewController = viewController
        toolbar.button.removeTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        toolbar.textField.delegate = nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        execute(text: textField.text ?? "")
        return true
    }

    @objc
    func buttonAction(sender: Any?) {
        guard let toolbar = toolbar else { return }

        execute(text: toolbar.textField.text ?? "")
    }

    private func execute(text: String) {
        toolbar?.textField.resignFirstResponder()
        toolbar?.textField.text = ""

        if text.isEmpty { return }

        if let name = repository.name() {
            _ = service.create(comment: text, name: name)
        } else {
            executeSetNameFlow()
        }
    }

    private func executeSetNameFlow() {
        let controller = UIAlertController(title: "Your name",
                                           message: "Please choose your name",
                                           preferredStyle: .alert)
        controller.addTextField()
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        controller.addAction(UIAlertAction(title: "Set", style: .default) { action in
            guard let textField = controller.textFields?.first else { return }
            guard let text = textField.text else { return }

            self.repository.set(name: text)
            self.execute(text: text)
        })
        viewController?.present(controller, animated: true)
    }
}
