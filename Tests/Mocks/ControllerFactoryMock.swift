//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import UIKit

class ControllerFactoryMock: ControllerCreating {

    let provider = ControllerMockProvider()
    var lastType: ControllerType?

    func makeController(of type: ControllerType) -> ControllerProviding {
        lastType = type
        return provider
    }

}

class ControllerMockProvider: ControllerProviding  {

    let controller = UIViewController()

}
