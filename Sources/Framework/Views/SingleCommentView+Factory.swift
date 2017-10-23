extension SingleCommentView {

    struct Factory {

        static func userAvatarView() -> UIView {
            let userAvatarView = UIView(frame: .zero)
            return userAvatarView
        }

        static func userInitialsLabel() -> UILabel {
            let userInitialsLabel = UILabel()
            return userInitialsLabel
        }

        static func userNameLabel() -> UILabel {
            let userNameLabel = UILabel()
            return userNameLabel
        }

        static func commentContextLabel() -> UILabel {
            let commentContextLabel = UILabel()
            return commentContextLabel
        }

        static func dateLabel() -> UILabel {
            let dateLabel = UILabel()
            return dateLabel
        }

    }

}
