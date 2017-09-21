@testable import ELDebateFramework
import Swinject
import SwinjectAutoregistration

class KeychainFixtures {

    static let testPinCode: String = "13160"

    static func enable() {
        let assembler = Assembler.defaultAssembler
        let authStorage = assembler.resolver ~> AuthTokenStoring.self

        authStorage.resetToken(forPinCode: KeychainFixtures.testPinCode)
    }

}
