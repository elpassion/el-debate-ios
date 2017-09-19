import Swinject

public extension Assembler {

    static var defaultAssembler: Assembler {
        return Assembler(defaultAssemblies)
    }

    static var defaultAssemblies: [Assembly] {
        return [MainAssembly(), PinEntryAssembly(), AnswerAssembly(), ValidatorAssembly(), APIAssembly()]
    }

}
