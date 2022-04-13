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
            let sceneNameLabelText: String
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
}
