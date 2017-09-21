import Foundation

enum RequestError: Error {

    case deserializationError(reason: String)
    case apiError(statusCode: Int)
    case deallocatedClientError
    case throttling

}
