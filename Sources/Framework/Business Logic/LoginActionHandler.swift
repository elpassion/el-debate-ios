import PromiseKit

protocol LoginActionHandling: AutoMockable {

    func login(with credentials: LoginCredentials) -> Promise<VoteContext>

}

class LoginActionHandler: LoginActionHandling {

    private let fetchDebateService: FetchDebateServiceProtocol
    private let loginService: LoginServiceProtocol
    private let tokenStorage: AuthTokenStoring
    private let formValidator: PinFormValidating

    init(fetchDebateService: FetchDebateServiceProtocol,
         loginService: LoginServiceProtocol,
         tokenStorage: AuthTokenStoring,
         formValidator: PinFormValidating) {
        self.fetchDebateService = fetchDebateService
        self.loginService = loginService
        self.tokenStorage = tokenStorage
        self.formValidator = formValidator
    }

    func login(with credentials: LoginCredentials) -> Promise<VoteContext> {
        return formValidator.validate(pinCode: credentials.pin)
            .then { addingStoredToken(into: PartialContext(credentials: $0), from: self.tokenStorage) }
            .then { fetchingMissingToken(into: $0, using: self.loginService, storedIn: self.tokenStorage) }
            .then { fetchingDebate(into: $0, using: self.fetchDebateService) }
            .then { $0.buildContext() }
    }

}

private func addingStoredToken(into context: PartialContext,
                               from storage: AuthTokenStoring) -> Promise<PartialContext> {
    let token = storage.getToken(forPinCode: context.credentials.pin)
    return Promise(value: context.with(token: token))
}

private func fetchingMissingToken(into context: PartialContext,
                                  using loginService: LoginServiceProtocol,
                                  storedIn storage: AuthTokenStoring) -> Promise<PartialContext> {
    guard context.authToken == nil else {
        return Promise(value: context)
    }

    return loginService.login(credentials: context.credentials).then { authToken in
        try storage.save(token: authToken, forPinCode: context.credentials.pin)
        return Promise(value: context.with(token: authToken))
    }
}

private func fetchingDebate(into context: PartialContext,
                            using fetchDebateService: FetchDebateServiceProtocol) -> Promise<PartialContext> {
    guard let authToken = context.authToken else {
        fatalError("Debate should never be fetched without authentication token")
    }

    return fetchDebateService.fetchDebate(authToken: authToken).then { debate in
        context.with(debate: debate)
    }
}
