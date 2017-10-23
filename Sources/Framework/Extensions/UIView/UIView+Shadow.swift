import UIKit

extension UIView {

    func dropShadow() {
        let shadowRectangle = bounds.insetBy(dx: -1.0, dy: -1.0)
        let shadowPath = UIBezierPath(roundedRect: shadowRectangle, cornerRadius: layer.cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.08
        layer.shadowPath = shadowPath.cgPath
    }

}
