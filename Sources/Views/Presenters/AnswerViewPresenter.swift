//
//  AnswerViewPresenter.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 16/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class AnswerViewPresenter {
    func present(debate: Debate, answerView: AnswerViewProviding) {
        answerView.config(
            debateTitle: debate.topic,
            yesAnswerText: debate.positiveAnswer.value,
            undecidedAnswerText: debate.neutralAnswer.value,
            noAnswerText: debate.negativeAnswer.value
        )
    }
}
