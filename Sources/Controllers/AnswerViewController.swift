//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerViewController: UIViewController, ControllerProviding {

    // MARK: - Initializer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = AnswerView()
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
