@testable import ELDebateFramework
import Foundation

class FetchDebateResponseJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(
            json: [
                "topic": "debate_topic",
                "answers": [
                    "positive": ["id": 122, "value": "yes"],
                    "negative": ["id": 123, "value": "no"],
                    "neutral": ["id": 124, "value": "maybe"]
                ]
            ], error: nil)

        completionHandler(apiResponse)
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }
}
