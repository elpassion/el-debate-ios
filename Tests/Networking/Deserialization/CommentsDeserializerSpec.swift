@testable import ELDebateFramework
import Nimble
import Quick

class CommentsDeserializerSpec: QuickSpec {

    // swiftlint:disable function_body_length
    override func spec() {
        describe("Debate deserializer") {
            var deserializer: CommentsDeserializer!

            beforeEach {
                deserializer = CommentsDeserializer(jsonDecoder: JSONDecoder())
            }

            afterEach {
                deserializer = nil
            }

            describe("deserializing with success") {
                var deserialized: Comments!

                beforeEach {
                    let response: Any? = [
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
                                "id": 540,
                                "content": "test",
                                "full_name": "D M",
                                "created_at": 1507720943000,
                                "user_initials_background_color": "#b9cdce",
                                "user_initials": "DM",
                                "user_id": 309,
                                "status": "accepted"
                            ]
                        ],
                        "next_position": 531,
                        "debate_closed": false
                    ]

                    deserialized = try! deserializer.deserialize(json: response)
                }

                afterEach {
                    deserialized = nil
                }

                it("should have 2 comments") {
                    expect(deserialized.comments).to(haveCount(2))
                }

                describe("first comment") {
                    var firstComment: Comment!

                    beforeEach {
                        firstComment = deserialized.comments[1]
                    }

                    afterEach {
                        firstComment = nil
                    }

                    it("should have correct id") {
                        expect(firstComment.id) == 540
                    }

                    it("should have correct content") {
                        expect(firstComment.content) == "test"
                    }

                    it("should have correct fullName") {
                        expect(firstComment.fullName) == "D M"
                    }

                    it("should have correct createdAt") {
                        expect(firstComment.createdAt) == 1507720943000
                    }

                    it("should have correct userBackgroundColor") {
                        expect(firstComment.userBackgroundColor) == "#b9cdce"
                    }

                    it("should have userInitials") {
                        expect(firstComment.usersInitials) == "DM"
                    }

                    it("should have correct userId") {
                        expect(firstComment.userId) == 309
                    }

                    it("should have correct status") {
                        expect(firstComment.status) == CommentStatus.accepted
                    }
                }

                it("should have correct next_position") {
                    expect(deserialized.nextPosition) == 531
                }

                it("should have correct debate_closed status") {
                    expect(deserialized.debateClosed) == false
                }
            }

            describe("deserializing with failure") {
                it("throw emptyJson error") {
                    expect { _ = try deserializer.deserialize(json: nil) }
                        .to(throwError(CommentsDeserializerError.emptyJson))
                }
            }
        }
    }

}
