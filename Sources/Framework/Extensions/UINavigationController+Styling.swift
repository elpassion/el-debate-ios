import UIKit

extension UINavigationController {

    func applyDebateStyle() {
        navigationBar.barTintColor = UIColor(predefined: .navigationBar)
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

}
