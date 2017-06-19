//
//  Created by Jakub Turek on 19.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

struct PartialContext {

    let credentials: LoginCredentials
    let debate: Debate?
    let authToken: String?

    init(credentials: LoginCredentials, debate: Debate? = nil, authToken: String? = nil) {
        self.credentials = credentials
        self.debate = debate
        self.authToken = authToken
    }

}

extension PartialContext {

    func with(token: String?) -> PartialContext {
        return PartialContext(credentials: credentials, debate: debate, authToken: token)
    }

    func with(debate: Debate?) -> PartialContext {
        return PartialContext(credentials: credentials, debate: debate, authToken: authToken)
    }

}

extension PartialContext {

    func buildContext() -> VoteContext {
        guard let debate = debate, let authToken = authToken else {
            fatalError("Debate and/or auth token are missing")
        }

        return VoteContext(debate: debate, authToken: authToken, username: credentials.username)
    }

}
