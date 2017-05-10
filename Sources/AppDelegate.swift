//
//  Created by Jakub Turek on 10.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let router: Routing
    private let mainWindowFactory: MainWindowFactoryCreating

    var window: UIWindow?

    override init() {
        self.router = Router(navigator: UINavigationController())
        self.mainWindowFactory = MainWindowFactory(screenBounds: UIScreen.main.bounds)
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = mainWindowFactory.makeMainWindow(with: router.navigator)
        return true
    }

}
