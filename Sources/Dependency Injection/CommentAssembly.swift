//
//  CommentAssembly.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class CommentAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CommentViewController.self) { (resolver: Resolver, authToken: String) in
            let apiClient = resolver ~> APIProviding.self
            let alertView = resolver ~> AlertShowing.self
            let loadingView = resolver ~> LoadingViewShowing.self

            return CommentViewController(
                authToken: authToken,
                apiClient: apiClient,
                alertView: alertView,
                loadingView: loadingView
            )
        }
    }
}
