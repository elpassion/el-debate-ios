//
//  KeychainMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 15/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

class KeychainMock: KeychainStoring {
    var error: Error?
    var storedValues: [String: Any?] = [:]

    func set(_ value: String, key: String) throws {
        if let error = error {
            throw error
        } else {
            storedValues[key] = value
        }
    }

    func get(_ key: String) throws -> String? {
        if let error = error {
            throw error
        } else {
            return storedValues[key] as? String
        }
    }

    func remove(_ key: String) throws {
        if let error = error {
            throw error
        } else {
            storedValues[key] = nil
        }
    }
}
