//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit

protocol LoginActionHandling: AutoMockable {

    func login(with credentials: LoginCredentials) -> Promise<VoteContext>

}

class LoginActionHandler: LoginActionHandling {

    private let apiClient: APIProviding
    private let tokenStorage: AuthTokenStoring
    private let formValidator: PinFormValidating

    init(apiClient: APIProviding, tokenStorage: AuthTokenStoring, formValidator: PinFormValidating) {
        self.apiClient = apiClient
        self.tokenStorage = tokenStorage
        self.formValidator = formValidator
    }

    func login(with credentials: LoginCredentials) -> Promise<VoteContext> {
        return formValidator.validate(username: credentials.username, pinCode: credentials.pin)
            .then { addingStoredToken(into: PartialContext(credentials: $0), from: self.tokenStorage) }
            .then { fetchingMissingToken(into: $0, using: self.apiClient, storedIn: self.tokenStorage) }
            .then { fetchingDebate(into: $0, using: self.apiClient) }
            .then { $0.buildContext() }
    }

}

private func addingStoredToken(into context: PartialContext,
                               from storage: AuthTokenStoring) -> Promise<PartialContext> {
    let token = storage.getToken(forPinCode: context.credentials.pin)
    return Promise(value: context.with(token: token))
}

private func fetchingMissingToken(into context: PartialContext, using apiClient: APIProviding,
                                  storedIn storage: AuthTokenStoring) -> Promise<PartialContext> {
    guard context.authToken == nil else {
        return Promise(value: context)
    }

    return apiClient.login(pinCode: context.credentials.pin).then { authToken in
        try storage.save(token: authToken, forPinCode: context.credentials.pin)
        return Promise(value: context.with(token: authToken))
    }
}

private func fetchingDebate(into context: PartialContext, using apiClient: APIProviding) -> Promise<PartialContext> {
    guard let authToken = context.authToken else {
        fatalError("Debate should never be fetched without authentication token")
    }

    return apiClient.fetchDebate(authToken: authToken).then { debate in
        context.with(debate: debate)
    }
}
