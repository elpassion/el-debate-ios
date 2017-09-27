import UIKit

public protocol MainWindowCreating {

    func makeMainWindow(with navigationController: UINavigationController) -> UIWindow

}

public class MainWindowFactory: MainWindowCreating {

    private let screenBounds: CGRect

    init(screenBounds: CGRect) {
        self.screenBounds = screenBounds
    }

    public func makeMainWindow(with navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: screenBounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        window.rootViewController = navigationController

        return window
    }

}
