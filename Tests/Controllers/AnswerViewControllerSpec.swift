//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class AnswerViewControllerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("AnswerViewController") {
            var controller: AnswerViewController!
            var apliClient: APIProviderStub!
            var alertView: AlertViewMock!

            beforeEach {
                apliClient = APIProviderStub()
                alertView = AlertViewMock()
                controller = AnswerViewController(
                    voteContext: VoteContext.testDefault,
                    apiClient: apliClient,
                    alertView: alertView
                )
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title) == "EL Debate"
                }

                it("should have a valid snaphot") {
                    controller.view.frame = UIScreen.main.bounds

                    expect(controller.view).to(haveValidDeviceAgnosticSnapshot())
                }
            }

            describe("chat button tap") {
                it("should invoke chat button tapped callback with auth token") {
                    var authenticationToken: String?

                    controller.onChatButtonTapped = { authToken in
                        authenticationToken = authToken
                    }

                    controller.answerView.onChatButtonTapped?()

                    expect(authenticationToken).toEventually(equal("whatever"))
                }
            }

            describe("answer button tap") {
                it("should invoke voting") {
                    controller.answerView.onAnswerSelected?(.neutral)

                    expect(apliClient.votingAnswer?.identifier).toEventually(equal(2))
                    expect(apliClient.votingAuthToken).toEventually(equal("whatever"))
                }
            }

            describe("vote") {
                context("when failed") {
                    it("should show an alert message") {
                        apliClient.voteResult = Promise(error: RequestError.apiError(statusCode: 404))

                        controller.answerView.onAnswerSelected?(.negative)

                        expect(alertView.title).toEventually(equal("Error"))
                        expect(alertView.message).toEventually(equal("There was a problem submitting your vote"))
                    }
                }
            }
        }
    }

}
