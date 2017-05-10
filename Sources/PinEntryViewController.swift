//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

class PinEntryViewController: UIViewController {

    // MARK: - Initializer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = UIView()
    }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
