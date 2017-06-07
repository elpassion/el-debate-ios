//
//  Created by Jakub Turek on 07.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

class UserDefaultsFixtures {

    static func enable() {
        UserDefaults.standard.removeObject(forKey: "LastCredentials")
    }

}
