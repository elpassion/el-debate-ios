//
//  KeychainMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

class KeychainMock: KeychainStoring {
    var storedValues: [String: Any?] = [:]

    func set(_ value: String, key: String) throws {
        storedValues[key] = value
    }

    func get(_ key: String) throws -> String? {
        return storedValues[key] as? String
    }

    func remove(_ key: String) throws {
        storedValues[key] = nil
    }
}
