//
//  Created by Jakub Turek on 14.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

public struct LoginCredentials {

    public let pin: String
    public let username: String

    public init(pin: String, username: String) {
        self.pin = pin
        self.username = username
    }

}
