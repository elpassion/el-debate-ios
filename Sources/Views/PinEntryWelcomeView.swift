//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class PinEntryWelcomeView: UIView {

    private let container: UIStackView = Views.stack(axis: .vertical, distribution: .equalSpacing,
                                                     alignment: .fill, spacing: 10.0)
    private let welcomeLabel: UILabel = Views.label(size: 20.0, color: .black, alignment: .center,
                                                    numberOfLines: 0, text: "Welcome to")
    private let logo: UIImageView = Views.image(image: .logo, contentMode: .scaleAspectFit)

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        container.addArrangedSubview(welcomeLabel)
        container.addArrangedSubview(logo)

        addSubview(container)
    }

    // MARK: - Layout

    private func setUpLayout() {
        container.edgeAnchors == edgeAnchors
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
