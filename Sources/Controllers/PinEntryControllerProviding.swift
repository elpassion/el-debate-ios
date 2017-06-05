//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

public protocol PinEntryControllerProviding: class, ControllerProviding {

    var onVoteContextLoaded: ((VoteContext) -> Void)? { get set }

}
