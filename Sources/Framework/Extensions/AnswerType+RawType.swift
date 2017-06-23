//
//  Created by Jakub Turek on 29.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

extension AnswerType {

    public init?(rawType: Any?) {
        guard let rawType = rawType as? String else {
            return nil
        }
        guard let answerType = AnswerType(rawValue: rawType) else {
            return nil
        }

        self = answerType
    }

}
