import Anchorage
import UIKit

class CommentsView: UIView {

    let commentsTableView: UITableView = Factory.commentsTableView()
    private let background: UIImageView = Factory.background()

    public init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    private func setUpSubviews() {
        backgroundColor = UIColor(predefined: .screenBackground)
    }

    private func addSubviews() {
        addSubview(background)
        addSubview(commentsTableView)
    }

    private func setUpLayout() {
        background.centerXAnchor == centerXAnchor
        background.bottomAnchor == bottomAnchor - 20
        background.widthAnchor == widthAnchor * 0.95
        background.heightAnchor == background.widthAnchor * 0.75
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentsView {

    struct Factory {

        static func commentsTableView() -> UITableView {
            let commentsTableView = UITableView()
            commentsTableView.frame = UIScreen.main.bounds
            commentsTableView.backgroundColor = UIColor.clear
            commentsTableView.allowsSelection = false
            return commentsTableView
        }

        static func background() -> UIImageView {
            let background: UIImageView = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
            return background
        }

    }

}
