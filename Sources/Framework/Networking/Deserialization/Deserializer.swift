protocol Deserializing {

    associatedtype Result

    func deserialize(json: Any?) throws -> Result

}

class Deserializer<Result>: Deserializing {

    private let deserializeClosure: ((Any?) throws -> Result)

    required init<D: Deserializing>(_ deserializer: D) where D.Result == Result {
        deserializeClosure = deserializer.deserialize
    }

    func deserialize(json: Any?) throws -> Result {
        return try deserializeClosure(json)
    }

}
