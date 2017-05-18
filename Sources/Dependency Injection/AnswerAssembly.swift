//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(AnswerViewPresenter.self, initializer: AnswerViewPresenter.init)
        container.register(AnswerViewController.self) { (resolver: Resolver, voteContext: VoteContext) in

            let yearCalculator = resolver ~> CurrentYearCalculating.self
            let answerViewPresenter = resolver ~> AnswerViewPresenter.self
            let apiClient = resolver ~> APIProviding.self
            let alertView = resolver ~> AlertShowing.self

            return AnswerViewController(
                yearCalculator: yearCalculator,
                voteContext: voteContext,
                answerViewPresenter: answerViewPresenter,
                apiClient: apiClient,
                alertView: alertView
            )
        }
    }

}
