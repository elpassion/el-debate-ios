//
//  Answers.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 11/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

enum AnswerType: String {
    case positive
    case neutral
    case negative
}

struct Answer {
    let identifier: Int
    let value: String
}
