import Swinject

// swiftlint:disable no_extension_access_modifier

public extension Assembler {

    static var defaultAssembler: Assembler {
        return Assembler(defaultAssemblies)
    }

    static var defaultAssemblies: [Assembly] {
        return [MainAssembly(), PinEntryAssembly(), AnswerAssembly(), CommentAssembly(), ValidatorAssembly(), APIAssembly()]
    }

}
