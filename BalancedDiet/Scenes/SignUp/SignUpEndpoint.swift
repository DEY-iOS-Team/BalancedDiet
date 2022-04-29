//
//  SignUpEndpoint.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 29.04.22.
//

enum SignUpEndpoint: FirestoreEndpointProtocol {
    case save(id: String)

    var collectionId: String {
        return "users"
    }

    var documentId: String {
        switch self {
        case .save(let id):
            return id
        }
    }
}
