//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class AnswerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AnswerViewController.self) { (resolver: Resolver, debate: Debate) in
            let yearCalculator = resolver ~> CurrentYearCalculating.self

            return AnswerViewController(yearCalculator: yearCalculator, debate: debate)
        }
    }

}
