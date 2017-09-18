import Swinject

public extension Assembler {

    static var defaultAssembler: Assembler {
        guard let assembler = try? Assembler(assemblies: defaultAssemblies) else {
            fatalError("Could not build default assembly")
        }

        return assembler
    }

    static var defaultAssemblies: [Assembly] {
        return [MainAssembly(), PinEntryAssembly(), AnswerAssembly(), ValidatorAssembly(), APIAssembly()]
    }

}
