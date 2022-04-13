//
//  ShadowManager.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 10.04.22.
//

import UIKit

enum ShadowManager {
    static func setUpShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.black.cgColor
    }
}
