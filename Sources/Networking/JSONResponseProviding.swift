//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Alamofire

protocol JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void)

}

extension DataRequest: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        responseJSON { dataRequest in
            guard let response = dataRequest.response else { fatalError("Missing api response") }

            let apiResponse = ApiResponse(json: dataRequest.value, statusCode: response.statusCode)
            completionHandler(apiResponse)
        }
    }
}
