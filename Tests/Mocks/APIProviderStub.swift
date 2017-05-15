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

    func login(pinCode: String) -> Promise<String> {
        self.pinCode = pinCode
        return Promise { fulfill, reject in
            fulfill(authenticationToken)
        }
    }

    func fetchDebate(authToken: String) -> Promise<Debate> {
        debateAuthToken = authToken

        let debate = Debate(
            topic: "whatever",
            positiveAnswer: Answer(identifier: 123, value: "yes"),
            neutralAnswer: Answer(identifier: 124, value: "maybe"),
            negativeAnswer: Answer(identifier: 125, value: "no")
        )

        return Promise { fulfill, reject in
            fulfill(debate)
        }
    }

}
