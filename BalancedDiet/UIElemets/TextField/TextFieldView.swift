//
//  TextFieldView.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 10.04.22.
//

import UIKit
import SnapKit

final class TextFieldView: UIView {
    // MARK: - Nested Types
    enum TextFieldStyle {
        case email
        case password
        case repeatPassword
        case userName
        case custom
    }

    private enum Constants {
        static let toggleButtonSize: CGFloat = 24
        static let textFieldHeight: CGFloat = 48
        static let cornerRadius: CGFloat = 16
        static let normalInset: CGFloat = 16
    }

    // MARK: - Properties
    var model: TextFieldViewModel? {
        didSet {
            setupTextField()
        }
    }

    private var style: TextFieldStyle
    private var maxNumber: Int?

    private var placeholder: String? {
        didSet {
            guard
                let placeholder = placeholder,
                let color = R.color.text()
            else { return }

            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }

    // MARK: - UI Properties
    private let textField = TextField()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.red()
        label.font = R.font.poppinsSemiBold(size: 16)
        label.numberOfLines = 0

        return label
    }()

    private lazy var toggleButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(
            x: 0,
            y: 0,
            width: Constants.toggleButtonSize,
            height: Constants.toggleButtonSize
        )
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(toggleButtonPressed), for: .touchUpInside)

        return button
    }()

    // MARK: - Initialiaztion
    init(style: TextFieldStyle) {
        self.style = style
        super.init(frame: .zero)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in TextFieldView")
    }

    // MARK: - Internal Methods
    func setError(error: String) {
        errorMessageLabel.text = error
        textField.layer.borderWidth = 1
        textField.layer.borderColor = R.color.red()?.cgColor
    }

    func clearError() {
        errorMessageLabel.text = String.empty
        textField.layer.borderWidth = 0.2
        textField.layer.borderColor = R.color.accent()?.cgColor
    }

    func getCurrentTextFieldText() -> String {
        return textField.text ?? String.empty
    }

    // MARK: - Private Methods
    private func configureView() {
        textField.delegate = self
        createModel()
        setSubviews()
        setLayout()
    }

    private func createModel() {
        switch style {
        case .email:
            model = TextFieldViewModel(
                leftImage: UIImage(systemName: "envelope"),
                placeholder: R.string.textFieldLocalization.emailPlaceholderText(),
                maxNumber: 320
            )
        case .password:
            model = TextFieldViewModel(
                leftImage: UIImage(systemName: "lock"),
                placeholder: R.string.textFieldLocalization.passwordPlaceholderText(),
                maxNumber: 50,
                isSecureTextEntry: true
            )
        case .repeatPassword:
            model = TextFieldViewModel(
                leftImage: UIImage(systemName: "lock"),
                placeholder: R.string.textFieldLocalization.repeatPasswordPlaceholderText(),
                maxNumber: 50,
                isSecureTextEntry: true
            )
        case .userName:
            model = TextFieldViewModel(
                leftImage: UIImage(systemName: "person"),
                placeholder: R.string.textFieldLocalization.nicknamenamePlaceholderText(),
                maxNumber: 15
            )
        default:
            break
        }
    }

    private func setupTextField() {
        guard let model = model else { return }
        textField.leftImage = model.leftImage
        placeholder = model.placeholder
        textField.toggleButton = model.isSecureTextEntry ? toggleButton : nil
        maxNumber = model.maxNumber
    }

    private func setSubviews() {
        addSubview(textField)
        addSubview(errorMessageLabel)
    }

    private func setLayout() {
        textField.snp.makeConstraints {
            $0.height.equalTo(Constants.textFieldHeight)
            $0.top.leading.trailing.equalToSuperview()
        }

        errorMessageLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-6)
            $0.leading.trailing.equalToSuperview().inset(Constants.normalInset)
            $0.bottom.equalToSuperview()
        }
    }

    //MARK: - Actions
    @objc private func toggleButtonPressed() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        toggleButton.setImage(UIImage(systemName: textField.isSecureTextEntry ? "eye" : "eye.slash"), for: .normal)
    }
}

// MARK: - UITextFieldDelegate
extension TextFieldView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard
            let maxNumber = maxNumber
        else { return true }

        guard
            let text = textField.text,
            let rangeOfTextToReplace = Range(range, in: text)
        else { return false }

        let substringToReplace = text[rangeOfTextToReplace]
        let count = text.count - substringToReplace.count + string.count

        return count <= maxNumber
    }
}
