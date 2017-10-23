import Anchorage
import Foundation
import UIColor_Hex_Swift
import UIKit

internal class SingleCommentView: UIView {

    public let userAvatarView: UIView = Factory.userAvatarView()
    public let userInitialsLabel: UILabel = Factory.userInitialsLabel()
    public let userNameLabel: UILabel = Factory.userNameLabel()
    public let commentContextLabel: UILabel = Factory.commentContextLabel()
    public let dateLabel: UILabel = Factory.dateLabel()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        userAvatarView.addSubview(userInitialsLabel)
        addSubview(userAvatarView)
        addSubview(userNameLabel)
        addSubview(commentContextLabel)
        addSubview(dateLabel)
    }

    private func setupLayout() {
        setupAvatarLayout()
        setupUsernameLabelLayout()
        setupCommentContextLabelLayout()
        setupDateLabelLayout()
    }

    private func setupAvatarLayout() {
        userInitialsLabel.centerAnchors == userAvatarView.centerAnchors
        userAvatarView.heightAnchor == 40
        userAvatarView.widthAnchor == 40
        userAvatarView.leftAnchor == leftAnchor
        userAvatarView.topAnchor == topAnchor
        userAvatarView.bottomAnchor == bottomAnchor
    }

    private func setupUsernameLabelLayout() {

    }

    private func setupCommentContextLabelLayout() {

    }

    private func setupDateLabelLayout() {

    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
