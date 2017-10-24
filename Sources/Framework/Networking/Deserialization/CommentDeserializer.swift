class CommentDeserializer: Deserializing {

    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Deserializing

    func deserialize(json: Any?) throws -> Comment {
        guard let json = json else {
            throw CommentDeserializerError.emptyJson
        }
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        return try jsonDecoder.decode(Comment.self, from: jsonData)
    }

    // MARK: - Private

    private let jsonDecoder: JSONDecoder

}

enum CommentDeserializerError: Error {
    case emptyJson
}
