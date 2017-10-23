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
    private let inset: CGFloat = 10

    init() {
        super.init(frame: .zero)

        backgroundColor = UIColor.clear
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
        userAvatarView.leftAnchor == leftAnchor + inset
        userAvatarView.topAnchor == topAnchor + inset
        userAvatarView.bottomAnchor <= bottomAnchor - inset
    }

    private func setupUsernameLabelLayout() {
        userNameLabel.topAnchor == userAvatarView.topAnchor
        userNameLabel.leftAnchor == userAvatarView.rightAnchor + inset
    }

    private func setupCommentContextLabelLayout() {
        commentContextLabel.bottomAnchor == bottomAnchor - inset
        commentContextLabel.leftAnchor == userNameLabel.leftAnchor
        commentContextLabel.rightAnchor == dateLabel.leftAnchor
    }

    private func setupDateLabelLayout() {
        dateLabel.widthAnchor == 40
        dateLabel.rightAnchor == rightAnchor - inset
        dateLabel.centerYAnchor == userAvatarView.centerYAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
