extension AnswerType {

    init?(rawType: Any?) {
        guard let rawType = rawType as? String else {
            return nil
        }
        guard let answerType = AnswerType(rawValue: rawType) else {
            return nil
        }

        self = answerType
    }

}
