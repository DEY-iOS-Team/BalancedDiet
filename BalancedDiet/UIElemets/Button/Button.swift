//
//  Button.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

import UIKit
import SnapKit

final class Button: UIButton {
    // MARK: - Nested Types
    private enum Constants {
        static let height: CGFloat = 48
        static let shadowCornerRadius: CGFloat = 12
        static let shadowOpacity: Float = 0.2
        static let shadowRadius: CGFloat = 15
        static let sizeFont: CGFloat = 22
        static let semiAlpha: CGFloat = 0.5
        static let alpha: CGFloat = 1
        static let cornerRadius: CGFloat = 15
        static let contentInsets:CGFloat = 30
    }

    // MARK: - Properties
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? Constants.semiAlpha : Constants.alpha
        }
    }

    // MARK: - Initialiaztion
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureButton() {
        backgroundColor = R.color.accent()
        layer.cornerRadius = Constants.cornerRadius
        titleLabel?.font = titleLabel?.font.withSize(Constants.sizeFont)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Constants.contentInsets)
        ShadowManager.setUpShadow(for: self)
    }

    private func setupLayout() {
        snp.makeConstraints {
            $0.height.equalTo(Constants.height)
        }
    }
}
