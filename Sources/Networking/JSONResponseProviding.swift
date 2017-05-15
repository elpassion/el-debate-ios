//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Alamofire

protocol JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void)
    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void)

}

extension DataRequest: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        responseJSON { dataRequest in
            let apiResponse = ApiResponse(json: dataRequest.value, error: dataRequest.error)
            completionHandler(apiResponse)
        }
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        responseString { dataRequest in
            var json: Any?
            var requestError = dataRequest.error

            if let jsonData = dataRequest.data, !jsonData.isEmpty {
                do {
                    json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                } catch let error {
                    requestError = error
                }
            }

            completionHandler(
                ApiResponse(json: json, error: requestError)
            )
        }
    }
}
