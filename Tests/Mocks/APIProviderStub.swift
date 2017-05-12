//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate

class APIProviderStub: APIProviding {

    var pinCode: String?
    var authenticationToken = "12"

    func login(pinCode: String, completionHandler: @escaping (String?) -> Void) {
        self.pinCode = pinCode
        completionHandler(authenticationToken)
    }

    func fetchDebate(authToken: String, completionHandler: @escaping (Debate?) -> Void) {

    }

}
