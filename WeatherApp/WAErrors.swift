//
//  Errors.swift
//  WeatherApp
//
//  Created by Ярослав on 10/20/20.
//

import Foundation

enum WAError: Error {
    case invalidPswrd
    case invalidEMail
    case invalidBoth
    case emptyPswrd
    case emptyEMail
    case emptyBoth
}

func printError(_ error: Error) {
    print("[\(Date())][WeatherApp][Internal error][\(error.localizedDescription)]")
}

extension WAError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidPswrd:
            return NSLocalizedString("Password is invalid. Check it please", comment: "Invalid password")
        case .invalidEMail:
            return NSLocalizedString("E-mail is invalid. Check it please", comment: "Invalid e-mail")
        case .invalidBoth:
            return NSLocalizedString("E-mail and password are invalid. Check them please", comment: "Invalid e-mail and password")
        case .emptyPswrd:
            return NSLocalizedString("Password field is empty. Check it please", comment: "Empty password field")
        case .emptyEMail:
            return NSLocalizedString("E-mail field is empty. Check it please", comment: "Empty e-mail field")
        case .emptyBoth:
            return NSLocalizedString("E-mail and password fields are empty. Check them please", comment: "Empty e-mail and password fields")
        }
    }
}
