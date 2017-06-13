//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

class AuthTokenDeserializer: Deserializing {

    func deserialize(json: Any?) throws -> String {
        guard let dict = json as? [String: Any] else {
            throw RequestError.deserializationError(reason: "Response is not a dictionary")
        }

        guard let authToken = dict["auth_token"] as? String else {
            throw RequestError.deserializationError(reason: "Auth token is missing in a response")
        }

        return authToken
    }

}
