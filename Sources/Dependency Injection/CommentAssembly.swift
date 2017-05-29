//
//  CommentAssembly.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 19/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class CommentAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(CommentViewController.self,
                               argument: String.self,
                               initializer: CommentViewController.init)
    }

}
