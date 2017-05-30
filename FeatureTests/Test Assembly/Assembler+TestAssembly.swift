//
//  Created by Jakub Turek on 30.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Swinject
import SwinjectAutoregistration

extension Assembler {

    static var testAssembler: Assembler {
        let testAssemblies = defaultAssemblies + [TestAssembly()]

        guard let assembler = try? Assembler(assemblies: testAssemblies) else {
            fatalError("Could not build test assembly")
        }

        return assembler
    }

}
