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

    let keychain: KeychainStoring
    let kAuthToken = "kAuthToken"

    init(keychain: KeychainStoring) {
        self.keychain = keychain
    }

    func save(token authToken: String, forPinCode pinCode: String) throws {
        try keychain.set(authToken, key: key(forPinCode: pinCode))
    }

    func getToken(forPinCode pinCode: String) -> String? {
        do {
            if let token = try keychain.get(key(forPinCode: pinCode)) {
                return token
            }
        } catch { }

        return nil
    }

    private func key(forPinCode pinCode: String) -> String {
        return "\(kAuthToken):\(pinCode)"
    }

    func hasToken(forPinCode pinCode: String) -> Bool {
        if getToken(forPinCode: pinCode) != nil {
            return true
        } else {
            return false
        }
    }

}
