//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol CurrentYearCalculating {

    var year: String { get }

}

class CurrentYearCalculator: CurrentYearCalculating {

    private let currentDateProvider: () -> Date

    init(currentDateProvider: @escaping () -> Date) {
        self.currentDateProvider = currentDateProvider
    }

    var year: String {
        return yearFormatter.string(from: currentDateProvider())
    }

    private lazy var yearFormatter: DateFormatter = {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        return yearFormatter
    }()

}
