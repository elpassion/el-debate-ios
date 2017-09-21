import Foundation

public enum AnswerType: String {

    case positive
    case neutral
    case negative

}

// swiftlint:disable no_extension_access_modifier

public extension AnswerType {

    static var allTypes: [AnswerType] {
        return [
            .positive,
            .neutral,
            .negative
        ]
    }

}

public struct Answer {

    let identifier: Int
    let value: String
    let type: AnswerType

}
