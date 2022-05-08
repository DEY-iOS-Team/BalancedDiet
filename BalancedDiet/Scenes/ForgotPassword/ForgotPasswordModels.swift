//
//  ForgotPasswordModels.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

enum ForgotPassword {
    enum InitialData {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {
            let titleText: String
            let loginLinkButtonTitle: String
        }
    }

    enum ResetPasswordData {
        struct Request {
            let email: String
        }

        struct Response {
            let authResult: AuthResult
        }

        struct ViewModel {
            let authResult: AuthResult
        }

        enum AuthResult {
            case success(model: FirebaseFirestoreDTO.resetPassword)
            case failure(error: String)
        }
    }
}
