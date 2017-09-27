import Foundation

protocol AuthTokenStoring {

    func save(token authToken: String, forPinCode pinCode: String) throws
    func getToken(forPinCode pinCode: String) -> String?
    func hasToken(forPinCode pinCode: String) -> Bool
    func resetToken(forPinCode pinCode: String)

}

class AuthTokenStorage: AuthTokenStoring {

    private let keychain: KeychainStoring

    // MARK: - Initialization

    init(keychain: KeychainStoring) {
        self.keychain = keychain
    }

    // MARK: - Public API

    func save(token authToken: String, forPinCode pinCode: String) throws {
        try keychain.set(authToken, key: key(forPinCode: pinCode))
    }

    func getToken(forPinCode pinCode: String) -> String? {
        guard let token = try? keychain.get(key(forPinCode: pinCode)) else {
            return nil
        }

        return token
    }

    func hasToken(forPinCode pinCode: String) -> Bool {
        return getToken(forPinCode: pinCode) != nil
    }

    func resetToken(forPinCode pinCode: String) {
        try? keychain.remove(key(forPinCode: pinCode))
    }

    // MARK: - Utility

    private let keychainEntryPrefix: String = "kAuthToken"

    private func key(forPinCode pinCode: String) -> String {
        return "\(keychainEntryPrefix):\(pinCode)"
    }

}
