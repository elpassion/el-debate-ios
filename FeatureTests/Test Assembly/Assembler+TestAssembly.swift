@testable import ELDebateFramework
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
