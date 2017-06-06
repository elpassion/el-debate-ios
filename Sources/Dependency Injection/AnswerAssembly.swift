//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(InputAlertPresenting.self, initializer: InputAlertPresenter.init)
        container.register(AnswerViewController.self) { (resolver: Resolver, voteContext: VoteContext) in
            let apiClient = resolver ~> APIProviding.self
            let alertView = resolver ~> AlertShowing.self
            let inputAlertPresenter = resolver ~> InputAlertPresenting.self

            return AnswerViewController(
                voteContext: voteContext,
                apiClient: apiClient,
                alertView: alertView,
                inputAlertPresenter: inputAlertPresenter
            )
        }
    }

}
