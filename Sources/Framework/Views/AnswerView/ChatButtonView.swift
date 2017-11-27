import Anchorage
import UIKit

class ChatButtonView: UIView {

    private let chatButton: UIButton = Views.button(style: .buttonTitle, backgroundColor: .navigationBar,
                                                    cornerRadius: 3.0, title: "Chat")

    var onChatButtonTapped: (() -> Void)?

    init() {
        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    // MARK: - Layout subviews (shadow)

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        chatButton.addTarget(self, action: #selector(didTapChatButton), for: .touchUpInside)
        chatButton.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
        chatButton.setBackgroundImage(.from(color: .highlightedButton), for: .highlighted)
    }

    private func addSubviews() {
        addSubview(chatButton)
    }

    // MARK: - Layout

    private func setUpLayout() {
        chatButton.edgeAnchors == edgeAnchors
    }

    // MARK: - Chat button tap

    @objc
    private func didTapChatButton() {
        onChatButtonTapped?()
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
