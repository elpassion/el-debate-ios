//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit

protocol LoginActionHandling: AutoMockable {

    func login(withPinCode pinCode: String) -> Promise<String>

}

class LoginActionHandler: LoginActionHandling {

    private let apiClient: APIProviding
    private let tokenStorage: AuthTokenStoring

    init(apiClient: APIProviding, tokenStorage: AuthTokenStoring) {
        self.apiClient = apiClient
        self.tokenStorage = tokenStorage
    }

    func login(withPinCode pinCode: String) -> Promise<String> {
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
