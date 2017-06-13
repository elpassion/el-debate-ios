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
    let username: String?

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

public extension VoteContext {

    func copy(withUsername username: String) -> VoteContext {
        return VoteContext(debate: debate,
                           authToken: authToken,
                           username: username)
    }

}
