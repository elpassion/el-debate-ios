//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerViewController: UIViewController, ControllerProviding {

    private let yearCalculator: CurrentYearCalculating
    private let debate: Debate

    // MARK: - Initializer

    init(yearCalculator: CurrentYearCalculating, debate: Debate) {
        self.yearCalculator = yearCalculator
        self.debate = debate

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = AnswerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "EL Debate \(yearCalculator.year)"
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
