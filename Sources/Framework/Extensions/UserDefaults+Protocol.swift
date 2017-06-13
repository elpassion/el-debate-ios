//
//  Created by Jakub Turek on 07.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol UserDefaultsStore {

    func string(forKey defaultName: String) -> String?
    func set(_ value: Any?, forKey defaultName: String)

}

extension UserDefaults: UserDefaultsStore {}
