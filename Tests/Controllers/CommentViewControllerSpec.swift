//
//  CommentViewControllerSpec.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import PromiseKit
import Quick
import UIKit

class CommentViewControllerSpec: QuickSpec {
    override func spec() {
        var controller: CommentViewController!
        let authToken: String = "123456"
        var apiClient: APIProviderStub!
        var alertView: AlertViewMock!
        var loadingView: LoadingViewShowing!
        var keyboardHandler: KeyboardWillShowHandlerMock!

        beforeEach {
            apiClient = APIProviderStub()
            alertView = AlertViewMock()
            loadingView = LoadingViewPresenter()
            keyboardHandler = KeyboardWillShowHandlerMock()

            controller = CommentViewController(
                authToken: authToken,
                apiClient: apiClient,
                alertView: alertView,
                loadingView: loadingView,
                keyboardHandling: keyboardHandler
            )
        }

        afterEach {
            controller = nil
        }

        describe("after view is loaded") {
            beforeEach {
                controller.viewDidLoad()
            }

            it("should set title") {
                expect(controller.title).to(equal("Comment"))
            }

            it("should have a correct comment view loaded") {
                expect(controller.view).to(beAKindOf(CommentView.self))
            }
        }

        describe("submit button tapped") {
            context("there was a problem submitting a comment") {
                beforeEach {
                    apiClient.commentReturnValue = Promise(error: RequestError.apiError(statusCode: 500))
                }
                it("shows an error alert") {
                    controller.onSubmitButtonTapped()
                    expect(alertView.wasShown).toEventually(equal(true))
                }
            }
        }

        describe("keyboard event") {
            beforeEach {
                controller.viewDidLoad()
            }

            it("should play the animation with keyboard height") {
                keyboardHandler.onKeyboardHeightChanged?(242.0)

                expect(controller.commentView.buttonBottom?.constant).to(equal(CGFloat(-242.0)))
            }
        }
    }
}
