//
//  CommentControllerProviding.swift
//  ELDebate
//
//  Created by Pawel Urbanek on 22/05/2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Foundation

protocol CommentControllerProviding: class, ControllerProviding {

    var onCommentSubmitted: (() -> Void)? { get set }

}
