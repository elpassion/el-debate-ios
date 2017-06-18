//
// Created by Jakub Turek on 18.06.2017.
// Copyright (c) 2017 EL Passion. All rights reserved.
//

import Foundation

public enum UsernameValidatorError: Error {

    case missing

}

extension UsernameValidatorError: AlertPresentableError {

    public var errorMessage: String {
        switch self {
        case .missing:
            return "The username is required"
        }
    }

}
