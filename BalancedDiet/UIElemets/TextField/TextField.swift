//
//  TextField.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 10.04.22.
//

import UIKit

final class TextField: UITextField {
    // MARK: - Nested Types
    private enum Constants {
        static let imageViewSize: CGFloat = 25
        static let textPadding: CGFloat = 40
        static let leftViewPadding: CGFloat = 10
        static let rightViewPadding: CGFloat = -10
        static let cornerRadius: CGFloat = 16
        static let bevel: CGFloat = 4
        static let smallPoint: CGFloat = 2
        static let opacity: Float = 1
    }

    // MARK: - Properties
    var leftImage: UIImage? {
        didSet {
            self.setLeftView()
        }
    }

    var toggleButton: UIButton? {
        didSet {
            self.setRightView()
        }
    }

    private var padding = UIEdgeInsets(
        top: 0,
        left: Constants.textPadding,
        bottom: 0,
        right: Constants.textPadding
    )

    private var leftPadding: CGFloat
    private var rightPadding: CGFloat

    // MARK: - Initialiaztion
    override init(frame: CGRect = .zero) {
        leftPadding = Constants.leftViewPadding
        rightPadding = Constants.rightViewPadding
        super.init(frame: frame)
        configureTextField()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in TextField")
    }

    // MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return super.leftViewRect(forBounds: bounds)
            .offsetBy(dx: leftPadding, dy: 0)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return super.rightViewRect(forBounds: bounds)
            .offsetBy(dx: rightPadding, dy: 0)
    }

    // MARK: - Private Methods
    private func configureTextField() {
        backgroundColor = R.color.white()
        font = R.font.sfProTextLight(size: 22)
        autocapitalizationType = .none
        layer.cornerRadius = Constants.cornerRadius
        ShadowManager.setUpShadow(for: self)
    }

    private func setLeftView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let viewForLeftImage = UIView(
                frame: CGRect(x: 0, y: 0, width: Constants.imageViewSize, height: Constants.imageViewSize)
            )
            let imageView = UIImageView(
                frame: CGRect(x: 0, y: 0, width: Constants.imageViewSize, height: Constants.imageViewSize)
            )
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = R.color.accent()
            viewForLeftImage.addSubview(imageView)
            leftView = viewForLeftImage
        }
    }

    private func setRightView() {
        if let toggleButton = toggleButton {
            rightViewMode = UITextField.ViewMode.always
            isSecureTextEntry = true
            let rightButtonView = UIView(
                frame: CGRect(x: 0, y: 0, width: Constants.imageViewSize, height: Constants.imageViewSize)
            )
            toggleButton.tintColor = R.color.accent()
            rightButtonView.addSubview(toggleButton)
            rightView = rightButtonView
        }
    }
}
