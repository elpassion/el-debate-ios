//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit

protocol LoginActionHandling: AutoMockable {

    func login(withPinCode pinCode: String) -> Promise<VoteContext>

}

class LoginActionHandler: LoginActionHandling {

    private let apiClient: APIProviding
    private let tokenStorage: AuthTokenStoring

    init(apiClient: APIProviding, tokenStorage: AuthTokenStoring) {
        self.apiClient = apiClient
        self.tokenStorage = tokenStorage
    }

    func login(withPinCode pinCode: String) -> Promise<VoteContext> {
        return fetchAuthToken(forPinCode: pinCode).then { [weak self] authToken -> Promise<(String, Debate)> in
            guard let `self` = self else {
                return Promise(error: RequestError.deallocatedClientError)
            }

            return when(fulfilled: Promise(value: authToken), self.apiClient.fetchDebate(authToken: authToken))
        }.then { (authToken, debate) in
            let voteContext = VoteContext(debate: debate, authToken: authToken)
            return Promise(value: voteContext)
        }
    }

    private func fetchAuthToken(forPinCode pinCode: String) -> Promise<String> {
        if let authToken = tokenStorage.getToken(forPinCode: pinCode) {
            return Promise(value: authToken)
        } else {
            return apiClient.login(pinCode: pinCode).then { [unowned self] authToken in
                try self.tokenStorage.save(token: authToken, forPinCode: pinCode)
                return Promise(value: authToken)
            }
        }
    }

}
