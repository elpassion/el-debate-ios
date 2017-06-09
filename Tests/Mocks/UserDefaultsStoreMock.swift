//
//  Created by Jakub Turek on 07.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

class UserDefaultsStoreMock: UserDefaultsStore {

    var store: [String: Any?] = [:]

    func string(forKey defaultName: String) -> String? {
        return store[defaultName] as? String
    }

    func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }

}
