import UIKit

extension UIImage {

    convenience init?(predefined: Image) {
        self.init(named: predefined.rawValue,
                  in: Bundle(for: MainAssembly.self),
                  compatibleWith: nil)
    }

}
