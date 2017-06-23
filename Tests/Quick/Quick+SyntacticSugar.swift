//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Quick

public func when(_ description: String, closure: @escaping () -> Void) {
    context("when \(description)", closure)
}

public func whether(_ description: String, closure: @escaping () -> Void) {
    context("whether \(description)", closure)
}
