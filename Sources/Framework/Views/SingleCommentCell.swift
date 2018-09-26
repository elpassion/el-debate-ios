import Anchorage
import UIColor_Hex_Swift
import UIKit

class SingleCommentCell: UITableViewCell {

    let singleCommentView: SingleCommentView = SingleCommentView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor.clear
        addSubview(singleCommentView)
        singleCommentView.edgeAnchors == edgeAnchors
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
