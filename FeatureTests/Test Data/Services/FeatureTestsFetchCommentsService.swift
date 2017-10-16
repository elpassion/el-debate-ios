@testable import ELDebateFramework
import PromiseKit

class FeatureTestsFetchCommentsService: FetchCommentsServiceProtocol {

    var debateAuthToken: String?

    func fetchComments(authToken: String) -> Promise<Comments> {
        let testCommentOne = Comment(id: 0, content: "Cool comment", fullName: "John Wayne", createdAt: 1507721053000,
                                     userBackgroundColor: "#efe0d2", usersInitials: "JW", userId: 342, status: .accepted)
        let testCommentTwo = Comment(id: 1, content: "Another really random comment", fullName: "John Wayne", createdAt: 1507721053000,
                                     userBackgroundColor: "#efe0d2", usersInitials: "JW", userId: 342, status: .accepted)

        let commentsTestList = Comments(comments: [testCommentOne, testCommentTwo], nextPosition: 3, debateClosed: false)
        return Promise(value: commentsTestList)
    }

}
