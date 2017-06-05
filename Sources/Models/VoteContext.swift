//
//  VoteContext.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 16/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

public struct VoteContext {

    let debate: Debate
    let authToken: String

}

public extension VoteContext {

    func answer(for answerType: AnswerType) -> Answer {
        switch answerType {
        case .positive:
            return debate.positiveAnswer
        case .neutral:
            return debate.neutralAnswer
        case .negative:
            return debate.negativeAnswer
        }
    }

}
