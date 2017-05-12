//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol PinEntryControllerProviding: class, ControllerProviding {

    var onSuccessfulLogin: ((String) -> Void)? { get set }

}
