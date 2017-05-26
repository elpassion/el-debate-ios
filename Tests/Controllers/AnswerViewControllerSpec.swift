//
//  Created by Jakub Turek on 15.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebate
import Nimble
import Nimble_Snapshots
import Quick

class AnswerViewControllerSpec: QuickSpec {

    override func spec() {
        describe("AnswerViewController") {
            var yearCalculator: CurrentYearCalculatorMock!
            var controller: AnswerViewController!
            var apliClient: APIProviderStub!

            beforeEach {
                yearCalculator = CurrentYearCalculatorMock()
                yearCalculator.year = "2012"
                apliClient = APIProviderStub()
                controller = AnswerViewController(
                    yearCalculator: yearCalculator,
                    voteContext: VoteContext.testDefault,
                    apiClient: apliClient,
                    alertView: AlertViewMock()
                )
            }

            describe("after view is loaded") {
                beforeEach {
                    controller.viewDidLoad()
                }

                it("should set title") {
                    expect(controller.title).to(equal("EL Debate 2012"))
                }

                it("should have a valid snaphot") {
                    controller.view.frame = UIScreen.main.bounds

                    expect(controller.view).to(haveValidDeviceAgnosticSnapshot())
                }
            }

            describe("comment button tap") {
                it("should invoke comment button tapped callback with auth token") {
                    var authenticationToken: String?

                    controller.onCommentButtonTapped = { authToken in
                        authenticationToken = authToken
                    }

                    controller.answerView.onCommentButtonTapped?()

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
        }
    }
}
