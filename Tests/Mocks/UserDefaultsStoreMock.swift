@testable import ELDebateFramework

class UserDefaultsStoreMock: UserDefaultsStore {

    var store: [String: Any?] = [:]

    func string(forKey defaultName: String) -> String? {
        return store[defaultName] as? String
    }

    func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }

}
