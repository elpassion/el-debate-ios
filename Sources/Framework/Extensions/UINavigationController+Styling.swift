//
//  Created by Jakub Turek on 13.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

extension UINavigationController {

    func applyDebateStyle() {
        navigationBar.barTintColor = UIColor(predefined: .navigationBar)
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
    }

}
