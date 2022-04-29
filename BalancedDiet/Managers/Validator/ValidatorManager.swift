//
//  ValidatorManager.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//

import Foundation

enum ValidatorType {
    case userName
    case email
    case password

    var validationValue: String {
        switch self {
        case .userName:
            return "(?=.*?[A-Z]).{4,10}"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password:
            return "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,20}$"
        }
    }
}

final class ValidatorManager: ValidatorProtocol{
    func validate(with text: String, type: ValidatorType) -> Bool {
        var predicate = NSPredicate()
        switch type {
        case .userName:
            predicate = NSPredicate(format: "SELF MATCHES %@", type.validationValue)
        case .email:
            predicate = NSPredicate(format: "SELF MATCHES %@", type.validationValue)
        case .password:
            predicate = NSPredicate(format: "SELF MATCHES %@", type.validationValue)
        }
        return predicate.evaluate(with: text)
    }
}
