//
//  Created by Jakub Turek on 06.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import UIKit

protocol CommentControllerPresenting: AutoMockable {

    func present(in controller: UIViewController)

}

class CommentControllerPresenter: CommentControllerPresenting {

    func present(in controller: UIViewController) {

    }

}
