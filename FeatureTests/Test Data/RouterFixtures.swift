@testable import ELDebate
@testable import ELDebateFramework
import Swinject
import SwinjectAutoregistration

class RouterFixtures {

    static let assembler: Assembler = Assembler.testAssembler

    static func enable() {
        let router = assembler.resolver ~> Routing.self
        let applicationDelegate = UIApplication.shared.delegate as? AppDelegate

        applicationDelegate?.router = router
        applicationDelegate?.window?.rootViewController = router.navigator
        router.go(to: .pinEntry)
    }

}
