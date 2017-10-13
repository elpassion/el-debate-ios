class CommentsDeserializer: Deserializing {

    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Deserializing

    func deserialize(json: Any?) throws -> Comments {
        guard let json = json else {
            throw CommentsDeserializerError.emptyJson
        }
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        return try jsonDecoder.decode(Comments.self, from: jsonData)
    }

    // MARK: - Private

    private let jsonDecoder: JSONDecoder

}

enum CommentsDeserializerError: Error {
    case emptyJson
}
