import KeychainAccess

protocol KeychainStoring {
    func set(_ value: String, key: String) throws
    func get(_ key: String) throws -> String?
    func remove(_ key: String) throws
}

extension Keychain: KeychainStoring {}
