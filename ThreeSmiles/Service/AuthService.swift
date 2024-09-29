//
//  AuthService.swift
//  ThreeSmiles
//
//  Created by Wei Wu on 2024/09/29.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthService {
    static let shared = AuthService()

    // Singleton
    private init() {}

    func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthError.missingClientID))
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthError.invalidGoogleCredentials))
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let user = authResult?.user {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.unknownFirebaseError))
                }
            }
        }
    }
}

enum AuthError: Error {
    case missingClientID
    case invalidGoogleCredentials
    case unknownFirebaseError

    var localizedDescription: String {
        switch self {
        case .missingClientID:
            return "Failed to get client ID from Firebase configuration."
        case .invalidGoogleCredentials:
            return "Failed to get valid credentials from Google Sign-In."
        case .unknownFirebaseError:
            return "An unknown error occurred during Firebase authentication."
        }
    }
}
