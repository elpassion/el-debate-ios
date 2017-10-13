import Foundation

public enum CommentStatus: String, Decodable {
    case accepted
    case rejected
    case pending
}

extension CommentStatus {

    public static var allTypes: [CommentStatus] {
        return [.accepted, .rejected, .pending]
    }
}

public struct Comments: Decodable {
    let comments: [Comment]
    let nextPosition: Int
    let debateClosed: Bool
}

extension Comments {

    private enum CodingKeys: String, CodingKey {
        case comments
        case nextPosition = "next_position"
        case debateClosed = "debate_closed"
    }

}

struct Comment: Decodable {
    let id: Int
    let content: String
    let fullName: String
    let createdAt: Int
    let userBackgroundColor: String
    let usersInitials: String
    let userId: Int
    let status: CommentStatus
}

extension Comment {

    private enum CodingKeys: String, CodingKey {
        case id
        case content
        case fullName = "full_name"
        case createdAt = "created_at"
        case userBackgroundColor = "user_initials_background_color"
        case usersInitials = "user_initials"
        case userId = "user_id"
        case status
    }

}
