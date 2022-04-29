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

    enum LoginData {
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

extension Login.LoginData {
    enum AuthResult {
        case success(model: FirebaseFirestoreDTO.User)
        case failure(error: ErrorType)
    }

    enum ErrorType {
        case validationError(message: [ValidationError])
        case firebaseAuthError(message: String)
    }

    enum ValidationError: Error {
        case email
        case password

        var message: String {
            switch self {
            case .email:
                return R.string.validatorLocalization.emptyEmail()
            case .password:
                return R.string.validatorLocalization.emptyPassword()
            }
        }
    }
}
