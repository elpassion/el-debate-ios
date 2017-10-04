import Swinject
import SwinjectAutoregistration

class ValidatorAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(PinCodeValidator.self, initializer: PinCodeValidator.init)

        container.register(PinFormValidating.self) { resolver in
            let pinValidator = resolver ~> PinCodeValidator.self

            return PinFormValidator(pinCodeValidator: AnyValidator(pinValidator))
        }
    }

}
