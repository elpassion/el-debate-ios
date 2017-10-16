@testable import ELDebateFramework

extension Comments {

    static var testDefault: Comments {
        return Comments(comments: [comment], nextPosition: 2, debateClosed: false)
    }

    static var comment: Comment {
        return Comment(id: 0, content: "Cool comment", fullName: "John Wayne", createdAt: 1507721053000,
                       userBackgroundColor: "#efe0d2", usersInitials: "JW", userId: 342, status: .accepted)
    }
}
