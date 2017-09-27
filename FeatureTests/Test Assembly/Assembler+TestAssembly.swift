@testable import ELDebateFramework
import Swinject
import SwinjectAutoregistration

extension Assembler {

    static var testAssembler: Assembler {
        let testAssemblies = defaultAssemblies + [TestAssembly()]

        return Assembler(testAssemblies)
    }

}
