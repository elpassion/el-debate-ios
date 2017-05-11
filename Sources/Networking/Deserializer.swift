//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

protocol Deserializing {

    associatedtype Result

    func deserialize(json: Any?) throws -> Result

}

class Deserializer<Result>: Deserializing {

    private let _deserialize: ((Any?) throws -> Result)

    required init<D: Deserializing>(deserializer: D) where D.Result == Result {
        _deserialize = deserializer.deserialize
    }

    func deserialize(json: Any?) throws -> Result {
        return try _deserialize(json)
    }
}
