import Alamofire
@testable import ELDebateFramework
import Nimble
import PromiseKit
import Quick

class FetchCommentsServiceSpec: QuickSpec {

    override func spec() {
        describe("FetchCommentsService") {
            var requestExecutor: RequestExecutingMock!
            var fetchCommentsService: FetchCommentsService!
            var URL: URLProvider!
            beforeEach {
                requestExecutor = RequestExecutingMock()
                URL = URLProvider()
                fetchCommentsService = FetchCommentsService(requestExecutor: requestExecutor,
                                                            commentsDeserializer: Deserializer(CommentsDeserializer(jsonDecoder:JSONDecoder())),
                                                            URLProvider: URL)
            }

            afterEach {
                requestExecutor = nil
                URL = nil
                fetchCommentsService = nil
            }
            
        }
    }
}
