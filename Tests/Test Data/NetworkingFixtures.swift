//
//  Created by Jakub Turek on 30.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Mockingjay
import XCTest

class NetworkingFixtures {

    static func enable(for testCase: XCTestCase) {
        stubLogin(for: testCase)
        stubFetchDebate(for: testCase)
        stubVote(for: testCase)
    }

    private static func stubLogin(for testCase: XCTestCase) {
        let body: Any = ["auth_token": "token"]

        testCase.stub(uri("/api/login"), json(body))
    }

    private static func stubFetchDebate(for testCase: XCTestCase) {
        let body: Any = ["topic": "Party craft beer leggings Pitchfork VHS locavore?",
                         "answers": [
                            "positive": ["id": 1, "value": "Yes"],
                            "negative": ["id": 2, "value": "No"],
                            "neutral": ["id": 3, "value": "Undecided"]
                        ]]

        testCase.stub(uri("/api/debate"), json(body))
    }

    private static func stubVote(for testCase: XCTestCase) {
        let body: Any = ["success": true]

        testCase.stub(uri("/api/vote"), json(body))
    }

}
