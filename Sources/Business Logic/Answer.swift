//
//  Answers.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

public enum AnswerType: String {

    case positive
    case neutral
    case negative

}

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
