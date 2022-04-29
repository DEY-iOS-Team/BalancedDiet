//
//  LoginEndpoint.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 29.04.22.
//

enum LoginEndpoint: FirestoreEndpointProtocol {
    case get(id: String)

    var collectionId: String {
        return "users"
    }

    var documentId: String {
        switch self {
        case .get(let id):
            return id
        }
    }
}
