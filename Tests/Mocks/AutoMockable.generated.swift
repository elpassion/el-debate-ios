// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import ELDebateFramework
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
class FontSizeCalculatingMock: FontSizeCalculating {


    //MARK: - size

    var 
sizeCalled
 = false
    var sizeReceivedArguments: (fontSize: Double, screenHeight: Double)?
    var 
sizeReturnValue
: Double!

    func size(withReferenceSize fontSize: Double, forScreenHeight screenHeight: Double) -> Double {

sizeCalled
 = true
        sizeReceivedArguments = (fontSize: fontSize, screenHeight: screenHeight)
        return 
sizeReturnValue
    }
}
class LoginActionHandlingMock: LoginActionHandling {


    //MARK: - login

    var 
loginCalled
 = false
    var loginReceivedPinCode: String?
    var 
loginReturnValue
: Promise<VoteContext>!

    func login(withPinCode pinCode: String) -> Promise<VoteContext> {

loginCalled
 = true
        loginReceivedPinCode = pinCode
        return 
loginReturnValue
    }
}
class RequestExecutingMock: RequestExecuting {


    //MARK: - post

    var 
postCalled
 = false
    var postReceivedArguments: (url: URLConvertible, body: Parameters?, headers: HTTPHeaders?)?
    var 
postReturnValue
: JSONResponseProviding!

    func post(url: URLConvertible, body: Parameters?, headers: HTTPHeaders?) -> JSONResponseProviding {

postCalled
 = true
        postReceivedArguments = (url: url, body: body, headers: headers)
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
