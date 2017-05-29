//
//  Created by Jakub Turek on 29.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol NotificationManaging {

    func addObserver(forName name: NSNotification.Name?,
                     object obj: Any?,
                     queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol

    func removeObserver(_ observer: Any)

}

extension NotificationCenter: NotificationManaging { }
