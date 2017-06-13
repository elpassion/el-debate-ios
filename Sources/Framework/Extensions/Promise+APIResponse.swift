//
//  Created by Jakub Turek on 17.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import PromiseKit

extension Promise {

    typealias ApiRequestExecutor = (@escaping (ApiResponse) -> Void) -> Void
    typealias ApiRequestProcessor = (ApiResponse) throws -> T

    convenience init(requestExecutor: @escaping ApiRequestExecutor, processor: @escaping ApiRequestProcessor) {
        self.init { fulfill, reject in
            requestExecutor { response in
                if let error = response.error {
                    reject(error)
                    return
                }

                do {
                    fulfill(try processor(response))
                } catch let error {
                    reject(error)
                }
            }
        }
    }

}
