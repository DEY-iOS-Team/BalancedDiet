//
//  FirebaseFirestoreError.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 29.03.22.
//

import Foundation

enum FirebaseFirestoreError: Error {
    case defaultError
}

extension FirebaseFirestoreError: LocalizedError {
    var message: String? {
        switch self {
        case .defaultError:
            return R.string.dataLocalization.defaultError()
        }
    }
}
