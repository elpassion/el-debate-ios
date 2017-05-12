// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import ELDebate
import Foundation
import UIKit
import Alamofire
import PromiseKit




class ControllerConfiguringMock: ControllerConfiguring {


    //MARK: - configure

    var 
configureCalled
 = false
    var configureReceivedArguments: (controller: ControllerProviding, router: Routing)?

    func configure(controller: ControllerProviding, with router: Routing) {

configureCalled
 = true
        configureReceivedArguments = (controller: controller, router: router)
    }
}
class RequestExecutingMock: RequestExecuting {


    //MARK: - post

    var 
postCalled
 = false
    var postReceivedArguments: (url: URLConvertible, body: Parameters?)?
    var 
postReturnValue
: JSONResponseProviding!

    func post(url: URLConvertible, body: Parameters?) -> JSONResponseProviding {

postCalled
 = true
        postReceivedArguments = (url: url, body: body)
        return 
postReturnValue
    }
    //MARK: - get

    var 
getCalled
 = false
    var getReceivedArguments: (url: URLConvertible, headers: HTTPHeaders?)?
    var 
getReturnValue
: JSONResponseProviding!

    func get(url: URLConvertible, headers: HTTPHeaders?) -> JSONResponseProviding {

getCalled
 = true
        getReceivedArguments = (url: url, headers: headers)
        return 
getReturnValue
    }
}
