//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Alamofire

protocol RequestExecuting {

    func post(url: URL, body: Parameters?) -> JSONResponseProviding

}

extension DataRequest: JSONResponseProviding {

    func json(completionHandler: @escaping (Any?) -> Void) {
        responseJSON { dataRequest in
            completionHandler(dataRequest.value)
        }
    }
}

class RequestExecutor: RequestExecuting {

    func post(url: URL, body: Parameters?) -> JSONResponseProviding {
        return Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).validate()
    }
}
