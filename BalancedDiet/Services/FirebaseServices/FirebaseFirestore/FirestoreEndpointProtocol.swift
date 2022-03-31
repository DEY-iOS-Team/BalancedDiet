//
//  FirebaseEndpoint.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 28.03.22.
//

protocol FirestoreEndpointProtocol {
    var collectionId: String { get }
    var documentId: String { get }
}
