//
//  Created by Jakub Turek on 08.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class ProgressView: UIView {

    private let color: Color
    private let progressBar: UIView = UIView(frame: .zero)

    private var leadingConstraint: NSLayoutConstraint?

    init(color: Color) {
        self.color = color

        super.init(frame: .zero)

        setUpSubviews()
        addSubviews()
        setUpLayout()
    }

    func startAnimation() {
        setUpInitialPosition()
        animateProgress()
    }

    func stopAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.progressBar.alpha = 0.0
        }, completion: { _ in
            self.layer.removeAllAnimations()
        })
    }

    private func setUpInitialPosition() {
        leadingConstraint?.constant = -progressBar.frame.size.width
        layoutIfNeeded()
    }

    private func animateProgress() {
        progressBar.alpha = 1.0
        leadingConstraint?.constant = frame.size.width

        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut, .repeat], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }

    // MARK: - Subviews

    private func setUpSubviews() {
        progressBar.backgroundColor = UIColor(predefined: color)
        progressBar.alpha = 0.0
    }

    private func addSubviews() {
        addSubview(progressBar)
    }

    // MARK: - Layout

    private func setUpLayout() {
        progressBar.widthAnchor == widthAnchor * 0.6
        progressBar.heightAnchor == heightAnchor
        progressBar.bottomAnchor == bottomAnchor
        leadingConstraint = progressBar.leadingAnchor == leadingAnchor
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
