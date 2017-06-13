//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

extension UIImage {

    convenience init?(predefined: Image) {
        self.init(named: predefined.rawValue,
                  in: Bundle(for: MainAssembly.self),
                  compatibleWith: nil)
    }

}
