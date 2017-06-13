//
//  Keychain+KeychainStoring.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import KeychainAccess

protocol KeychainStoring {
    func set(_ value: String, key: String) throws
    func get(_ key: String) throws -> String?
    func remove(_ key: String) throws
}

extension Keychain: KeychainStoring {}
