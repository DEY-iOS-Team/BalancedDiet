//
//  LoginModels.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

import UIKit

enum Login {
    enum InitialData {
        struct Request {}

        struct Response {}

        struct ViewModel {
            let forgotpasswordButtonTitle: String
            let titleText: String
            let loginButtonTitle: String
            let loginWithGoogleButtonTitle: String
            let loginWithGoogleButtonImage: UIImage?
            let loginWithFacebookButtonImage: UIImage?
            let loginWithFacebookButtonTitle: String
            let haveAccountLabelText: String
            let routeToSignUpButtonTitle: String
            let lineViewText: String
        }
    }

    enum LoginValidation {
        struct Request {
            let email: String
            let password: String
        }

        struct Response {
            let authResult: AuthResult
        }

        struct ViewModel {
            let authResult: AuthResult
        }
    }
}

extension Login.LoginValidation {
    enum AuthResult {
        case success(model: FirebaseFirestoreDTO.User)
        case failure(error: ErrorType)
    }

    enum ErrorType {
        case validationError(message: [ValidationError])
        case firebaseAuthError(message: String)
    }

    enum ValidationError: Error {
        case email(error: ValidationErrorType)
        case password(error: ValidationErrorType)

        var message: String {
            switch self {
            case .email(.wrongFormat):
                return R.string.validatorLocalization.wrongFormatOfEmail()
            case .password(.wrongFormat):
                return R.string.validatorLocalization.wrongFormatOfPassword()
            case .email(error: .empty):
                return R.string.validatorLocalization.emptyEmail()
            case .password(error: .empty):
                return R.string.validatorLocalization.emptyPassword()
            }
        }
    }

    enum ValidationErrorType {
        case empty
        case wrongFormat
    }
}
