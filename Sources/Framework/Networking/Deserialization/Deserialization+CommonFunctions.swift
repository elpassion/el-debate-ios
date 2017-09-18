func parseDictionary(_ json: Any?) throws -> [String: Any] {
    guard let dict = json as? [String: Any] else {
        throw RequestError.deserializationError(reason: "Response is not a dictionary")
    }

    return dict
}

func parseField<T>(from dictionary: [String: Any], key: String, description: String) throws -> T {
    guard let parsed = dictionary[key] as? T else {
        throw RequestError.deserializationError(reason: "Response does not contain \(description)")
    }

    return parsed
}
