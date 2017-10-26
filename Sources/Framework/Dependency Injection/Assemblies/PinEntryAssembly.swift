import Swinject
import SwinjectAutoregistration

class PinEntryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(LoginCredentialsStoring.self) { _ in
            return LoginCredentialsStore(userDefaults: UserDefaults.standard)
        }

        container.autoregister(AlertShowing.self, initializer: AlertPresenter.init)
        container.autoregister(LoginActionHandling.self, initializer: LoginActionHandler.init)
        container.autoregister(PinEntryViewController.self, initializer: PinEntryViewController.init)
    }

}
