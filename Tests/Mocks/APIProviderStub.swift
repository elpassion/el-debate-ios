//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import PromiseKit

class APIProviderStub: APIProviding {

    var pinCode: String?
    var authenticationToken = "12"
    var debateAuthToken: String?

    var commentReturnValue: Promise<Bool>?

    func login(pinCode: String) -> Promise<String> {
        self.pinCode = pinCode
        return Promise(value: authenticationToken)
    }

    func fetchDebate(authToken: String) -> Promise<Debate> {
        debateAuthToken = authToken

        return Promise(value: Debate.testDefault)
    }
    
    func vote(authToken: String, answer: Answer) -> Promise<Answer> {
        return Promise(value: Answer.testDefault)
    }
    
    func comment(authToken: String, text: String) -> Promise<Bool> {
        if let commentValue = commentReturnValue {
            return commentValue
        } else {
            return Promise(value: true)
        }
    }
}
