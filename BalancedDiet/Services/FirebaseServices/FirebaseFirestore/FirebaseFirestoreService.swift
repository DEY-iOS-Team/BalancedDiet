//
//  FirestoreDatabase.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 28.03.22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseFirestoreService {
    // MARK: - Properties
    static let shared = FirebaseFirestoreService()
    private let database = Firestore.firestore()

    // MARK: - Initialization
    private init() {}

    // MARK: - Methods
    func getData<T: Decodable>(
        endpoint: FirestoreEndpointProtocol,
        completion: @escaping (Result<T, FirebaseFirestoreError>) -> Void
    ) {
        let docRef = database.collection(endpoint.collectionId).document(endpoint.documentId)
        docRef.getDocument(as: T.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
                print("success")
            case .failure:
                completion(.failure(.defaultError))
                print("failure")
            }
        }
    }

    func saveData<T: Encodable>(
        endpoint: FirestoreEndpointProtocol,
        model: T,
        completion: @escaping (Result<Void, FirebaseFirestoreError>) -> Void
    ) {
        let docRef = database.collection(endpoint.collectionId).document(endpoint.documentId)
        do {
            try docRef.setData(from: model)
            completion(.success(()))
        } catch {
            completion(.failure(.defaultError))
        }
    }

    func deleteData(
        endpoint: FirestoreEndpointProtocol,
        completion: @escaping (Result<Void, FirebaseFirestoreError>) -> Void
    ) {
        let docRef = database.collection(endpoint.collectionId).document(endpoint.documentId)
        docRef.delete { error in
            if  error != nil {
                completion(.failure(.defaultError))
            }
            completion(.success(()))
        }
    }
}
