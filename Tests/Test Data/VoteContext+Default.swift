//
//  VoteContext+Default.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 16/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework

extension VoteContext {

    static var testDefault: VoteContext {
        return VoteContext(
            debate: Debate.testDefault,
            authToken: "whatever",
            username: "some user"
        )
    }
}
