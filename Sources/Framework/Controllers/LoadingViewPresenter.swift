//
//  LoadingViewController.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 22/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

protocol LoadingViewShowing {

    func show(in controller: UIViewController)
    func hide()

}

class LoadingViewPresenter: LoadingViewShowing {

    private lazy var controller: UIViewController = {
        let controller = UIViewController()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        return controller
    }()

    // MARK: - Initialization

    init() {
        setupView()
    }

    // MARK: - Public API

    func show(in target: UIViewController) {
        target.present(controller, animated: true, completion: nil)
    }

    func hide() {
        controller.dismiss(animated: true, completion: nil)
    }

    // MARK: - Utility

    private func setupView() {
        controller.view.backgroundColor = .clear
        let cover = UIView(frame: controller.view.frame)
        cover.backgroundColor = .black
        cover.alpha = 0.7

        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

        cover.addSubview(spinner)
        controller.view.addSubview(cover)

        spinner.centerAnchors == cover.centerAnchors
        spinner.startAnimating()
    }

}
