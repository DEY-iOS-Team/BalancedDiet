//
//  AuthorizationService.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 23.03.22.
//

import FirebaseAuth

final class FirebaseAuthService {
    // MARK: - Properties
    static let shared = FirebaseAuthService()

    private var authUser: User? {
        return Auth.auth().currentUser
    }

    // MARK: - Initialization
    private init() {}

    // MARK: - Methods
    func createUser(with model: FirebaseDTO.CreateUser, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        Auth.auth().createUser(
            withEmail: model.email,
            password: model.password
        ) { [weak self] authResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        completion(.failure(.emailAlreadyInUse))
                    case .networkError:
                        completion(.failure(.networkError))
                    case .weakPassword:
                        completion(.failure(.weakPassword))
                    default:
                        completion(.failure(.unownError))
                    }
                }
            } else {
                self?.sendVerificationMail { result in
                    switch result {
                    case .success:
                        guard
                            let uid = authResult?.user.uid
                        else {
                            completion(.failure(.unownError))
                            return
                        }
                        completion(.success(uid))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    func signIn(with model: FirebaseDTO.CreateUser, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        Auth.auth().signIn(
            withEmail: model.email,
            password: model.password
        ) { authResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .userNotFound:
                        completion(.failure(.userNotFound))
                    case .invalidEmail:
                        completion(.failure(.invalidEmail))
                    case .networkError:
                        completion(.failure(.networkError))
                    case .wrongPassword:
                        completion(.failure(.wrongPassword))
                    default:
                        completion(.failure(.unownError))
                    }
                }
            } else {
                guard
                    let uid = authResult?.user.uid
                else {
                    completion(.failure(.unownError))
                    return
                }
                completion(.success(uid))
            }
        }
    }

    private func sendVerificationMail(completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        guard let authUser = authUser else {
            completion(.failure(.unownError))
            return
        }
        if !authUser.isEmailVerified {
            authUser.sendEmailVerification { error in
                if let error = error as NSError? {
                    if let errorCode = AuthErrorCode(rawValue: error.code) {
                        switch errorCode {
                        case .emailChangeNeedsVerification:
                            completion(.failure(.emailChangeNeedsVerification))
                        default:
                            completion(.failure(.unownError))
                        }
                    }
                }
            }
            completion(.success(()))
        }
    }

    func signOut(completion: (Result<Void, FirebaseError>) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .networkError:
                        completion(.failure(.unownError))
                    default:
                        completion(.failure(.unownError))
                    }
                }
            }
        }
    }
}
