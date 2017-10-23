extension UIView {
    func applyRoundedCorners() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
