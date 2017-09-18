extension Dictionary where Key == NSAttributedStringKey, Value == AnyObject {

    var stringAny: [String: Any] {
        let uniqueKeysWithValues: [(String, Any)] = map { ($0.key.rawValue, $0.value) }
        return [String: Any](uniqueKeysWithValues: uniqueKeysWithValues)
    }

}
