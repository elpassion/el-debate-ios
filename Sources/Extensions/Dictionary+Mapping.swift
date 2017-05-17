//
//  Created by Jakub Turek on 17.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

extension Dictionary {

    init(_ elements: [Element]) {
        self.init()

        elements.forEach { (key, value) in
            self[key] = value
        }
    }

    func mapValues<T>(_ mapper: (Value) -> T) -> [Key: T] {
        var result: [Key: T] = [:]

        for (key, value) in self {
            result[key] = mapper(value)
        }

        return result
    }

    func mapDictionary<T, U>(_ mapper: (Element) -> (T, U)) -> [T: U] {
        var result: [T: U] = [:]

        for (key, value) in self {
            let transformed = mapper((key, value))
            result[transformed.0] = transformed.1
        }

        return result
    }

}
