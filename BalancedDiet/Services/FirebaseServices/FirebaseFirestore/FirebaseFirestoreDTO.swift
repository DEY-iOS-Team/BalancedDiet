//
//  DocumentSerializableProtocol.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 29.03.22.
//

import Foundation

enum FirebaseFirestoreDTO {
    struct User: Codable {
        let userName: String
        let email: String
    }
}
