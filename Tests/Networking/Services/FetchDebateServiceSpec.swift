import Alamofire
@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

class FetchDebateServiceSpec: QuickSpec {

    override func spec() {
        describe("FetchDebateService") {
            var requestExecutor: RequestExecutingMock!
            var fetchDebateService: FetchDebateService!
            var URL: URLProvider!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                URL = URLProvider()
                fetchDebateService = FetchDebateService(requestExecutor: requestExecutor,
                                                        debateDeserializer: DebateDeserializer.build(),
                                                        URLProvider: URL)
            }

            afterEach {
                requestExecutor = nil
                fetchDebateService = nil
                URL = nil
            }

            describe("fetchDebate") {
                context("api request success") {
                    beforeEach {
                        requestExecutor.getReturnValue = FetchDebateResponseJSONMock()
                    }

                    it("returns deserialized Debate object") {
                        var debate: Debate?
                        _ = fetchDebateService.fetchDebate(authToken: "auth_token_value").then { debateResult in
                            debate = debateResult
                        }

                        expect(debate?.topic).toEventually(equal("debate_topic"))
                    }
                }
            }
        }
    }
}
