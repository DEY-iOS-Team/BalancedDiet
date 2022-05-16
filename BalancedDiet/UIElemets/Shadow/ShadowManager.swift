//
//  ShadowManager.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 10.04.22.
//

import UIKit

enum ShadowManager {
    static func setUpShadow(for view: UIView) {
        view.layer.shadowColor = R.color.semiLightGrey()?.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3.5
        view.layer.shadowColor = R.color.semiLightGrey()?.cgColor
    }
}
