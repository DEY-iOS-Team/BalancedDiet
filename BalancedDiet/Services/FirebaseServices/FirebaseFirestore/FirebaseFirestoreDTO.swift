//
//  DocumentSerializableProtocol.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 29.03.22.
//

import Foundation

enum FirebaseFirestoreDTO {
    struct User: Codable {
        let name: String
        let email: String
        let imageURL: String
    }
}
