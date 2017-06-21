//
//  Created by Jakub Turek on 30.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import PromiseKit

class FeatureTestsAPIClient: APIProviding {

    func comment(_ text: String, with voteContext: VoteContext) -> Promise<Bool> {
        return Promise(value: true)
    }

    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        return Promise(value: answer)
    }

    func login(credentials: LoginCredentials) -> Promise<String> {
        return Promise(value: "auth_token")
    }

    func fetchDebate(authToken: String) -> Promise<Debate> {
        let debate = Debate(topic: "Party craft beer leggings Pitchfork VHS locavore?",
                            positiveAnswer: Answer(identifier: 1, value: "Yes", type: .positive),
                            neutralAnswer: Answer(identifier: 3, value: "Undecided", type: .neutral),
                            negativeAnswer: Answer(identifier: 2, value: "No", type: .negative),
                            lastAnswerIdentifier: 1)

        return Promise(value: debate)
    }
    
}
