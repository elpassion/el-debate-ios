@testable import ELDebateFramework
import Nimble
import Nimble_Snapshots
import PromiseKit
import Quick

class AnswerViewControllerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("AnswerViewController") {
            var sut: AnswerViewControllerMock!
            var apiClient: APIProviderStub!
            var alertView: AlertViewMock!

            beforeEach {
                apiClient = APIProviderStub()
                alertView = AlertViewMock()

                sut = AnswerViewControllerMock(
                    voteContext: VoteContext.testDefault,
                    apiClient: apiClient,
                    alertView: alertView
                )
            }

            describe("after view is loaded") {
                beforeEach {
                    sut.viewDidLoad()
                }

                it("should set title") {
                    expect(sut.title) == "EL Debate"
                }

                it("should have a valid snaphot") {
                    sut.view.frame = UIScreen.main.bounds

                    expect(sut.view).to(haveValidDeviceAgnosticSnapshot())
                }

                it("should select initial answer") {
                    expect(sut.answerView.selectedAnswer) == AnswerType.negative
                }
            }

            describe("answer button tap") {
                it("should invoke voting") {
                    sut.answerView.onAnswerSelected?(.neutral)

                    expect(apiClient.votingAnswer?.identifier).toEventually(equal(2))
                    expect(apiClient.votingAuthToken).toEventually(equal("whatever"))
                }
            }

            describe("chat button tap") {
                beforeEach {
                    sut.answerView.onChatButtonTapped?()
                }

                it("should show CommentController") {

                }

            }

            describe("vote") {
                context("when failed") {
                    it("should show an alert message") {
                        apiClient.voteResult = Promise(error: RequestError.apiError(statusCode: 404))

                        sut.answerView.onAnswerSelected?(.negative)

                        expect(alertView.title).toEventually(equal("Error"))
                        expect(alertView.message).toEventually(equal("There was a problem submitting your vote"))
                    }
                }

                context("when failed because of throttling") {
                    it("should show a specific throttling alert") {
                        apiClient.voteResult = Promise(error: RequestError.throttling)

                        sut.answerView.onAnswerSelected?(.positive)

                        expect(alertView.title).toEventually(equal("Slow down"))
                        expect(alertView.message).toEventually(equal("You are voting too fast"))
                    }
                }
            }
        }
    }

}
