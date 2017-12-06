protocol UserInfoRepository {
    func name() -> String?
    func set(name: String)
}

class PersistentUserInfoRepository: UserInfoRepository {
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func name() -> String? {
        return self.userDefaults.string(forKey: "UserInfoRepository_name")
    }

    func set(name: String) {
        self.userDefaults.set(name, forKey: "UserInfoRepository_name")
        self.userDefaults.synchronize()
    }
}
