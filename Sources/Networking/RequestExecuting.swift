//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Alamofire

protocol RequestExecuting: AutoMockable {

    func post(url: URLConvertible, body: Parameters?) -> JSONResponseProviding
    func get(url: URLConvertible, headers: HTTPHeaders?) -> JSONResponseProviding
}

class RequestExecutor: RequestExecuting {

    func post(url: URLConvertible, body: Parameters?) -> JSONResponseProviding {
        return Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).validate()
    }

    func get(url: URLConvertible, headers: HTTPHeaders?) -> JSONResponseProviding {
        return Alamofire.request(
            url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers
        ).validate()
    }
}
