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
            let userNameLabel = Views.label(style: .userName, numberOfLines: 0)
            return userNameLabel
        }

        static func commentContextLabel() -> UILabel {
            let commentContextLabel = Views.label(style: .commentBody, numberOfLines: 0)
            return commentContextLabel
        }

        static func dateLabel() -> UILabel {
            let dateLabel = Views.label(style: .commentDate, numberOfLines: 0)
            return dateLabel
        }

    }

}
