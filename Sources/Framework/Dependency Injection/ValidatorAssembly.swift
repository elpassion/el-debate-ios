import Swinject
import SwinjectAutoregistration

class ValidatorAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(UsernameValidator.self, initializer: UsernameValidator.init)
        container.autoregister(PinCodeValidator.self, initializer: PinCodeValidator.init)

        container.register(PinFormValidating.self) { resolver in
            let pinValidator = resolver ~> PinCodeValidator.self
            let usernameValidator = resolver ~> UsernameValidator.self

            return PinFormValidator(usernameValidator: AnyValidator(usernameValidator),
                                    pinCodeValidator: AnyValidator(pinValidator))
        }
    }

}
