import Foundation

protocol UserDefaultsStore {

    func string(forKey defaultName: String) -> String?
    func set(_ value: Any?, forKey defaultName: String)

}

extension UserDefaults: UserDefaultsStore {}
