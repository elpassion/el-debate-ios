//
//  AnswerViewMock.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 16/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class AnswerViewMock: AnswerViewProviding {
    var debateTitle: String?
    var yesAnswerText: String?
    var undecidedAnswerText: String?
    var noAnswerText: String?
    
    func config(debateTitle: String, yesAnswerText: String, undecidedAnswerText: String, noAnswerText: String) {
        self.debateTitle = debateTitle
        self.yesAnswerText = yesAnswerText
        self.undecidedAnswerText = undecidedAnswerText
        self.noAnswerText = noAnswerText
    }
}
