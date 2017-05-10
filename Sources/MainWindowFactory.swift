//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol MainWindowCreating {

    func makeMainWindow(with navigationController: UINavigationController) -> UIWindow

}

class MainWindowFactory: MainWindowCreating {

    private let screenBounds: CGRect

    init(screenBounds: CGRect) {
        self.screenBounds = screenBounds
    }

    func makeMainWindow(with navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: screenBounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        window.rootViewController = navigationController

        return window
    }

}
