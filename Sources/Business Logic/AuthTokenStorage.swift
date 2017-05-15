//
//  KeychainStorage.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol AuthTokenStoring {
    func saveToken(_ value: String) throws
    func getToken() -> String?
    func hasToken() -> Bool
}

class AuthTokenStorage: AuthTokenStoring {
    let keychain: KeychainStoring
    let kAuthToken = "kAuthToken"

    init(keychain: KeychainStoring) {
        self.keychain = keychain
    }

    func saveToken(_ value: String) throws {
        try keychain.set(value, key: kAuthToken)
    }

    func getToken() -> String? {
        do {
            if let token = try keychain.get(kAuthToken) {
                return token
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }

    func hasToken() -> Bool {
        if getToken() != nil {
            return true
        } else {
            return false
        }
    }
}
