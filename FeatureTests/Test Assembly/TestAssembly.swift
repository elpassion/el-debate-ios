//
//  Created by Jakub Turek on 30.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Swinject
import SwinjectAutoregistration

class TestAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(APIProviding.self, initializer: FeatureTestsAPIClient.init)
    }

}
