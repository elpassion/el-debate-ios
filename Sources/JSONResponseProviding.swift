//
//  Created by Jakub Turek on 11.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Alamofire

protocol JSONResponseProviding {

    func json(completionHandler: @escaping (Any?) -> Void)

}
