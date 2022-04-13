//
//  FirebaseAuthError.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 23.03.22.
//

import Foundation

enum FirebaseAuthError: Error {
    case emailAlreadyInUse
    case userNotFound
    case invalidEmail
    case networkError
    case weakPassword
    case wrongPassword
    case emailChangeNeedsVerification
    case unownError
}

extension FirebaseAuthError: LocalizedError {
    var message: String? {
        switch self {
        case .emailAlreadyInUse:
            return R.string.dataLocalization.emailAlreadyInUse()
        case .userNotFound:
            return R.string.dataLocalization.userNotFound()
        case .invalidEmail:
            return R.string.dataLocalization.invalidEmail()
        case .networkError:
            return R.string.dataLocalization.networkError()
        case .weakPassword:
            return R.string.dataLocalization.weakPassword()
        case .wrongPassword:
            return R.string.dataLocalization.wrongPassword()
        case .emailChangeNeedsVerification:
            return R.string.dataLocalization.emailChangeNeedsVerification()
        case .unownError:
            return R.string.dataLocalization.unknownError()
        }
    }
}
