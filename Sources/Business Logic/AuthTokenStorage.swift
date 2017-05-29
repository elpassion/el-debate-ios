//
//  KeychainStorage.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol AuthTokenStoring {

    func save(token authToken: String, forPinCode pinCode: String) throws
    func getToken(forPinCode pinCode: String) -> String?
    func hasToken(forPinCode pinCode: String) -> Bool

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
        guard let token = try? keychain.get(key(forPinCode: pinCode)) else { return nil }
        return token
    }

    func hasToken(forPinCode pinCode: String) -> Bool {
        return getToken(forPinCode: pinCode) != nil
    }

    // MARK: - Utility

    private let keychainEntryPrefix = "kAuthToken"

    private func key(forPinCode pinCode: String) -> String {
        return "\(keychainEntryPrefix):\(pinCode)"
    }

}
