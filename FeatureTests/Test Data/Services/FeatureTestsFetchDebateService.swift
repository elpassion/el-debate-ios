@testable import ELDebateFramework
import PromiseKit

class FeatureTestsFetchDebateService: FetchDebateServiceProtocol {

    func fetchDebate(authToken: String) -> Promise<Debate> {
        let debate = Debate(topic: "Party craft beer leggings Pitchfork VHS locavore?",
                            positiveAnswer: Answer(identifier: 1, value: "Yes", type: .positive),
                            neutralAnswer: Answer(identifier: 3, value: "Undecided", type: .neutral),
                            negativeAnswer: Answer(identifier: 2, value: "No", type: .negative),
                            lastAnswerIdentifier: nil)

        return Promise(value: debate)
    }

}
