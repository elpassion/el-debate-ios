//
//  Created by Jakub Turek on 07.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol LoginCredentialsStoring: class {

    var lastCredentials: LoginCredentials? { get set }

}

class LoginCredentialsStore: LoginCredentialsStoring {

    private let userDefaults: UserDefaultsStore

    init(userDefaults: UserDefaultsStore) {
        self.userDefaults = userDefaults
    }

    var lastCredentials: LoginCredentials? {
        get {
            return userDefaults.string(forKey: userDefaultsKey)
                .flatMap { deserialize($0) }
        }
        set {
            guard let lastCredentials = newValue else {
                return
            }

            userDefaults.set(serialize(lastCredentials), forKey: userDefaultsKey)
        }
    }

    private let userDefaultsKey: String = "LastCredentials"

    // MARK: - Serialization / deserialization

    private func serialize(_ credentials: LoginCredentials) -> String? {
        let dictionary: [String: String] = [
            "pinCode": credentials.pinCode,
            "username": credentials.username
        ]

        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }

    private func deserialize(_ text: String) -> LoginCredentials? {
        guard let json = text.data(using: .utf8)
            .flatMap({ try? JSONSerialization.jsonObject(with: $0) }) as? [String: String] else {
            return nil
        }

        guard let pinCode = json["pinCode"] else {
            return nil
        }
        guard let username = json["username"] else {
            return nil
        }

        return LoginCredentials(pinCode: pinCode, username: username)
    }

}
