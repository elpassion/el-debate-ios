// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import ELDebate
import Foundation
import UIKit
import Alamofire




class APIProvidingMock: APIProviding {


    //MARK: - login

    var 
loginCalled
 = false
    var loginReceivedArguments: (pinCode: String, completionHandler: (String?) -> Void)?

    func login(pinCode: String, completionHandler: @escaping (String?) -> Void) {

loginCalled
 = true
        loginReceivedArguments = (pinCode: pinCode, completionHandler: completionHandler)
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
}
