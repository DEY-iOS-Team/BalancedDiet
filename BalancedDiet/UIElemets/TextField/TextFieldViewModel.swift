//
//  TextFieldViewModel.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 10.04.22.
//

import UIKit

struct TextFieldViewModel {
    var leftImage: UIImage?
    var placeholder: String?
    var maxNumber: Int?
    var isSecureTextEntry: Bool

    init(
        leftImage: UIImage? = nil,
        placeholder: String? = nil,
        maxNumber: Int? = nil,
        isSecureTextEntry: Bool = false
    ) {
        self.leftImage = leftImage
        self.placeholder = placeholder
        self.maxNumber = maxNumber
        self.isSecureTextEntry = isSecureTextEntry
    }
}
