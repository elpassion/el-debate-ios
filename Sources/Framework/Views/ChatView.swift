import Anchorage
import UIKit

class ChatView: UIView {

    private let tableView = Factory.tableView()
    private let customCell = Factory.customCell
    private let background = Factory.background()

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
        addSubview(tableView)
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

extension ChatView {

    struct Factory {

        static func tableView() -> UITableView {
            let tableView = UITableView()
            tableView.frame = UIScreen.main.bounds
            tableView.backgroundColor = UIColor.clear
            return tableView
        }

        static func background() -> UIImageView {
            let background: UIImageView = Views.image(image: .loginBackground, contentMode: .scaleAspectFit)
            return background
        }

        static func customCell() -> SingleCommentView {
            let customCell = SingleCommentView()
            return customCell
        }

    }

}
