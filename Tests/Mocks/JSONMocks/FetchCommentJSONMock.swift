@testable import ELDebateFramework
import Foundation

class FetchCommentsJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(
            json: [
                "comments": [
                    [
                        "id": 541,
                        "content": "test",
                        "full_name": "Maciej Nie ten",
                        "created_at": 1507721053000,
                        "user_initials_background_color": "#efe0d2",
                        "user_initials": "MN",
                        "user_id": 342,
                        "status": "accepted"
                    ],
                    [
                        "id": 532,
                        "content": "jf",
                        "full_name": "J P",
                        "created_at": 1507213079000,
                        "user_initials_background_color": "#b9cdce",
                        "user_initials": "JP",
                        "user_id": 329,
                        "status": "accepted"
                    ]
                ],
                "next_position": 531,
                "debate_closed": false
            ], error: nil)
        completionHandler(apiResponse)
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }
}

class DebateClosedFetchCommentsJSONMock: JSONResponseProviding {

    func json(completionHandler: @escaping (ApiResponse) -> Void) {
        let apiResponse = ApiResponse(
                json: [
                    "comments": [
                        [
                            "id": 534,
                            "content": "gg",
                            "full_name": "J P",
                            "created_at": 1507213116000,
                            "user_initials_background_color": "#b9cdce",
                            "user_initials": "JP",
                            "user_id": 329,
                            "status": "accepted"
                        ],
                        [
                            "id": 538,
                            "content": "xd",
                            "full_name": "Mac P",
                            "created_at": 1507214334000,
                            "user_initials_background_color": "#efc2c2",
                            "user_initials": "MP",
                            "user_id": 325,
                            "status": "accepted"
                        ]
                    ],
                    "next_position": 531,
                    "debate_closed": true

            ], error: nil)
        completionHandler(apiResponse)
    }

    func maybeJson(completionHandler: @escaping (ApiResponse) -> Void) {
        json(completionHandler: completionHandler)
    }
}
