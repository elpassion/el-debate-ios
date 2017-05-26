//
//  Created by Jakub Turek on 26.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

struct NotificationDescriptor<T> {

    let name: Notification.Name
    let parser: ([AnyHashable: Any]) -> T?

}
