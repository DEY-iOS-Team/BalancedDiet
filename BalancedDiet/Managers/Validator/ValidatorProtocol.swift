//
//  ValidatorProtocol.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//

protocol ValidatorProtocol: AnyObject {
    func validate(with text: String, type: ValidatorType) -> Bool
}
