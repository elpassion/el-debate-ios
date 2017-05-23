//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject

extension Assembler {

    static var defaultAssembler: Assembler {
        guard let assembler = try? Assembler(assemblies: defaultAssemblies) else {
            fatalError("Could not build default assembly")
        }

        return assembler
    }

    private static var defaultAssemblies: [Assembly] {
        return [MainAssembly(), PinEntryAssembly(), AnswerAssembly(), CommentAssembly()]
    }

}
