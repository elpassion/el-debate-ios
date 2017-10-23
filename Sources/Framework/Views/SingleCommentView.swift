import Anchorage
import Foundation
import UIColor_Hex_Swift
import UIKit

class SingleCommentView: UIView {

    public let userNameLabel: UILabel = UILabel()
    public let userAvatarView: UIView = UIView(frame: .zero)
    public let userInitialsLabel: UILabel = UILabel()
    public let dateLabel: UILabel = UILabel()
    public let commentContextLabel: UILabel = UILabel()

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
