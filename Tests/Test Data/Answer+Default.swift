//
//  Answer+Default.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 17/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate

extension Answer {

    static var testDefault: Answer {
        return Answer(identifier: 123, value: "Yes", type: .positive)
    }

}
