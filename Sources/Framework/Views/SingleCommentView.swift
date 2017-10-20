import Anchorage
import Foundation
import UIColor_Hex_Swift
import UIKit

class SingleCommentView: UIView {

    public let userInitialsLabel: UILabel = UILabel()

    init() {
        super.init(frame: .zero)

        setupSubviews()
        addLayoutSubviews()
    }

    private func setupSubviews() {

    }

    private func addLayoutSubviews() {
        addSubview(userInitialsLabel)
        userInitialsLabel.centerAnchors == centerAnchors
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
