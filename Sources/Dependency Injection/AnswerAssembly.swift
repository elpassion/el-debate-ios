//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AnswerViewController.self) { (resolver: Resolver, voteContext: VoteContext) in

            let yearCalculator = resolver ~> CurrentYearCalculating.self
            let apiClient = resolver ~> APIProviding.self
            let alertView = resolver ~> AlertShowing.self

            return AnswerViewController(
                yearCalculator: yearCalculator,
                voteContext: voteContext,
                apiClient: apiClient,
                alertView: alertView
            )
        }
    }

}
