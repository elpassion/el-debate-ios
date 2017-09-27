import Foundation

class UserDefaultsFixtures {

    static func enable() {
        UserDefaults.standard.removeObject(forKey: "LastCredentials")
    }

}
