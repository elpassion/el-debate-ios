//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

class AuthTokenDeserializer: Deserializing {

    func deserialize(json: Any?) throws -> String {
        let dict = try parseDictionary(json)
        let authToken: String = try parseField(from: dict, key: "auth_token", description: "auth token")

        return authToken
    }

}
