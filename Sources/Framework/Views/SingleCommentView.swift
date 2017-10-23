import Anchorage
import Foundation
import UIColor_Hex_Swift
import UIKit

internal class SingleCommentView: UIView {

    public let userNameLabel: UILabel = UILabel()
    public let userAvatarView: UIView = UIView(frame: .zero)
    public let userInitialsLabel: UILabel = UILabel()
    public let dateLabel: UILabel = UILabel()
    public let commentContextLabel: UILabel = UILabel()

    init() {
        super.init(frame: .zero)

        setupSubviews()
        addSubviews()
        setupLayout()
    }

    private func setupSubviews() {
        userAvatarView.setRadius(radius: 90)
    }

    private func addSubviews() {
        userAvatarView.addSubview(userInitialsLabel)
        addSubview(userAvatarView)
        addSubview(userNameLabel)
        addSubview(dateLabel)
        addSubview(commentContextLabel)
    }

    private func setupLayout() {
        userInitialsLabel.centerAnchors == userAvatarView.centerAnchors

    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

