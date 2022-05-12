//
//  AuthorizationService.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 23.03.22.
//

import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FacebookCore
import FacebookLogin

final class FirebaseAuthService {
    // MARK: - Properties
    static let shared = FirebaseAuthService()

    private var authUser: User? {
        return Auth.auth().currentUser
    }

    // MARK: - Initialization
    private init() {}

    // MARK: - Methods
    func createUser(
        with model: FirebaseAuthDTO.CreateUser,
        completion: @escaping (Result<String, FirebaseAuthError>) -> Void
    ) {
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

    func login(
        with model: FirebaseAuthDTO.SignIn,
        completion: @escaping (Result<Void, FirebaseAuthError>) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: model.email,
            password: model.password
        ) { authResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .userNotFound:
                        completion(.failure(.userNotFound))
                    case .networkError:
                        completion(.failure(.networkError))
                    case .wrongPassword:
                        completion(.failure(.wrongPassword))
                    default:
                        completion(.failure(.unownError))
                    }
                }
            } else {
                if (authResult?.user.uid) != nil {
                    self.checkVerificationEmail { result in
                        switch result {
                        case .success:
                            completion(.success(()))
                        case .failure:
                            completion(.failure(.emailChangeNeedsVerification))
                        }
                    }
                } else {
                    completion(.failure(.unownError))
                }
            }
        }
    }

    func loginWithGoogle(
        vc: UIViewController,
        completion: @escaping (Result<FirebaseAuthDTO.LoginWithCredential, FirebaseAuthError>) -> Void
    ) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [weak self] user, error in
            if error != nil {
                completion(.failure(.unownError))
             }
             guard
               let authentication = user?.authentication,
               let idToken = authentication.idToken
             else {
                 completion(.failure(.unownError))
                 return
             }
             let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: authentication.accessToken
             )
            guard let self = self else { return }
            self.loginWithCredential(with: credential, completion: completion)
        }
    }

    func loginWithFacebook(
        vc: UIViewController,
        completion: @escaping (Result<FirebaseAuthDTO.LoginWithCredential, FirebaseAuthError>) -> Void
    ) {
        LoginManager().logIn(permissions: [], viewController: vc) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_, let declined, let token):
                    if let token = token, declined.isEmpty {
                        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                        self.loginWithCredential(with: credential, completion: completion)
                    } else {
                        completion(.failure(.unownError))
                    }
                case .failed:
                    completion(.failure(.unownError))
                case .cancelled:
                    break
                }
            }
    }

    func resetPassword(
        with email: String,
        completion: @escaping (Result<Void, FirebaseAuthError>) -> Void
    ) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                completion(.failure(.unownError))
            } else {
                completion(.success(()))
            }
        }
    }

    func signOut(completion: (Result<Void, FirebaseAuthError>) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            completion(.failure(.unownError))
        }
    }

    // MARK: - Private Methods
    private func checkVerificationEmail(completion: @escaping (Result<Void, FirebaseAuthError>) -> Void) {
        guard let authUser = authUser else {
            completion(.failure(.unownError))
            return
        }
        if !authUser.isEmailVerified {
            completion(.failure(.emailChangeNeedsVerification))
        } else {
            completion(.success(()))
        }
    }

    private func sendVerificationMail(completion: @escaping (Result<Void, FirebaseAuthError>) -> Void) {
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

    private func loginWithCredential(
        with credential: AuthCredential,
        completion: @escaping (Result<FirebaseAuthDTO.LoginWithCredential, FirebaseAuthError>) -> Void
    ) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if error != nil {
                completion(.failure(.unownError))
            } else {
                guard
                    let user = authResult?.user,
                    let username = user.displayName,
                    let email = user.email
                else {
                    completion(.failure(.unownError))
                    return
                }

                let response = FirebaseAuthDTO.LoginWithCredential(
                    uid: user.uid,
                    username: username,
                    email: email
                )
                completion(.success(response))
            }
        }
    }
}
