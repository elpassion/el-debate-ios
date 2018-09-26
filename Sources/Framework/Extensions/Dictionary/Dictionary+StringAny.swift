import Foundation

extension Dictionary where Key == NSAttributedString.Key, Value == AnyObject {

    var stringAny: [String: Any] {
        let uniqueKeysWithValues: [(String, Any)] = map { ($0.key.rawValue, $0.value) }
        return [String: Any](uniqueKeysWithValues: uniqueKeysWithValues)
    }

}
