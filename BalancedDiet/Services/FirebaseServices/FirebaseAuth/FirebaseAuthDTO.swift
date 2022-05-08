//
//  FirebaseAuthDTO.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 24.03.22.
//

import Foundation

enum FirebaseAuthDTO {
    struct SignIn {
        var email: String
        var password: String
    }

    struct CreateUser {
        var email: String
        var password: String
    }
}
