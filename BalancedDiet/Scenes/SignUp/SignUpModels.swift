//
//  Signup.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

import Foundation

enum SignUp {
    enum InitialData {
        struct Request {}

        struct Response {}

        struct ViewModel {
            let titleText: String
            let signUpButtonTitle: String
            let haveAccountLabelText: String
            let routeToLoginButtonTitle: String
        }
    }

    enum SignUpValidation {
        struct Request {
            let userName: String
            let email: String
            let password: String
            let confirmPassword: String
        }

        struct Response {
            let authResult: AuthResult
        }

        struct ViewModel {
            let authResult: AuthResult
        }
    }
}

extension SignUp.SignUpValidation {
    enum AuthResult {
        case success
        case failure(error: ErrorType)
    }

    enum ErrorType {
        case validationError(message: [ValidationError])
        case firebaseAuthError(message: String)
    }

    enum ValidationError: Error {
        case userName(error: ValidationErrorType)
        case email(error: ValidationErrorType)
        case password(error: ValidationErrorType)
        case confirmPassword(error: ValidationErrorType)

        var message: String {
            switch self {
            case .userName(.wrongFormat):
                return R.string.validatorLocalization.wrongFormatOfUserName()
            case .email(.wrongFormat):
                return R.string.validatorLocalization.wrongFormatOfEmail()
            case .password(.wrongFormat):
                return R.string.validatorLocalization.wrongFormatOfPassword()
            case .confirmPassword(.wrongFormat):
                return R.string.validatorLocalization.mismatchedPassword()
            case .userName(error: .empty):
                return R.string.validatorLocalization.emptyUsername()
            case .email(error: .empty):
                return R.string.validatorLocalization.emptyEmail()
            case .password(error: .empty):
                return R.string.validatorLocalization.emptyPassword()
            case .confirmPassword(error: .empty):
                return R.string.validatorLocalization.emptyConfirnPassword()
            }
        }
    }

    enum ValidationErrorType {
        case empty
        case wrongFormat
    }
}
