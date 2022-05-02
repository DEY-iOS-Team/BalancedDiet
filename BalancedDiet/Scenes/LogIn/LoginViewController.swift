//
//  LoginViewController.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 5.04.22.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    // MARK: - Nested Types
    private enum Constants {
        static let height: CGFloat = 50
        static let verticalStackViewSpacing: CGFloat = 20
        static let horizontalStackViewSpacing: CGFloat = 2
        static let inset: CGFloat = 16
        static let multiplier: CGFloat = 0.01
        static let bottomOffset: CGFloat = 10
        static let topOffset: CGFloat = 20
        static let fontSize: CGFloat = 30
    }

    // MARK: - Properties
    private let interactor: LoginBusinessLogic
    private let router: LoginRoutingLogic

    // MARK: - UI Properties
    private let containerView = UIView()
    private let lineView = LineView()
    private let haveAccountLabel = UILabel()
    private let emailTextField = TextFieldView(style: .email)
    private let passwordTextField = TextFieldView(style: .password)
    private let loginButton = Button()

    private let loginWithGoogleButton: Button = {
        let button = Button()
        button.backgroundColor = R.color.signupWithGoogle()
        return button
    }()

    private let loginWithFacebookButton: Button = {
        let button = Button()
        button.backgroundColor = R.color.signupWithFacebook()
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsSemiBold(size: Constants.fontSize)
        return label
    }()

    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let routeToSignUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalStackViewSpacing
        return stackView
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [loginButton, lineView, loginWithGoogleButton, loginWithFacebookButton]
        )
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalStackViewSpacing
        return stackView
    }()

    private lazy var haveAccountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [haveAccountLabel, routeToSignUpButton])
        stackView.axis = .horizontal
        stackView.spacing = Constants.horizontalStackViewSpacing
        return stackView
    }()

    // MARK: - Initialization
    init(interactor: LoginBusinessLogic, router: LoginRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in LoginViewController")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        startSettings()
    }

    // MARK: - Private Methods
    private func startSettings() {
        fetchInitialData()
    }

    private func configureView() {
        view.backgroundColor = R.color.background()

        setupSubviews()
        setupLayout()
        setupActions()
        setupHideKeyboardOnTap()
    }

    private func setupSubviews() {
        view.addSubviews(
             titleLabel,
            textFieldsStackView,
            forgotPasswordButton,
            buttonsStackView,
            haveAccountStackView
        )
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(Constants.inset)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(view.frame.height * Constants.multiplier)
        }

        textFieldsStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.inset)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.topOffset)
        }

        forgotPasswordButton.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(Constants.inset)
            $0.top.equalTo(textFieldsStackView.snp.bottom)
        }

        buttonsStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.inset)
            $0.bottom.equalTo(haveAccountStackView.snp.top).offset(-Constants.bottomOffset)
        }

        haveAccountStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.bottomOffset)
        }
    }

    private func validationErrorType(error: Login.LoginData.ValidationError) {
        switch error {
        case .email:
            emailTextField.setError(error: error.message)
        case .password:
            passwordTextField.setError(error: error.message)
        }
    }

    private func processError(error: Login.LoginData.ErrorType) {
        switch error {
        case .validationError(let errors):
            errors.forEach { validationError in
                validationErrorType(error: validationError)
            }
        case .firebaseAuthError(message: let message):
            print(message)
        }
    }

    private func setupActions() {
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginWithGoogleButton.addTarget(self, action: #selector(loginWithGooglePressed), for: .touchUpInside)
        loginWithFacebookButton.addTarget(self, action: #selector(loginWithFacebookPressed), for: .touchUpInside)
        routeToSignUpButton.addTarget(self, action: #selector(routeToSignUpPressed), for: .touchUpInside)
    }

    private func clearAllError() {
        emailTextField.clearError()
        passwordTextField.clearError()
    }

    //MARK: - Actions
    @objc private func forgotPasswordButtonPressed() {
        router.routeToForgotPassword()
    }

    @objc private func loginButtonPressed() {
        clearAllError()

        let email = emailTextField.getCurrentTextFieldText()
        let password = passwordTextField.getCurrentTextFieldText()
        interactor.login(request: Login.LoginData.Request(email: email, password: password))
    }

    @objc private func loginWithGooglePressed() {}

    @objc private func loginWithFacebookPressed() {}

    @objc private func routeToSignUpPressed() {
        router.routeToSignUp()
    }

    // MARK: - Interactor Methods
    func fetchInitialData() {
        let request = Login.InitialData.Request()
        interactor.fetchInitialData(request: request)
    }
}

// MARK: - LoginDisplayLogic
extension LoginViewController: LoginDisplayLogic {
    func displayInititalData(viewModel: Login.InitialData.ViewModel) {
        forgotPasswordButton.setTitle(viewModel.forgotpasswordButtonTitle, for: .normal)
        titleLabel.text = viewModel.titleText
        loginButton.setTitle(viewModel.loginButtonTitle, for: .normal)
        loginWithGoogleButton.setTitle(viewModel.loginWithGoogleButtonTitle, for: .normal)
        loginWithGoogleButton.setImage(viewModel.loginWithGoogleButtonImage, for: .normal)
        loginWithFacebookButton.setTitle(viewModel.loginWithFacebookButtonTitle, for: .normal)
        loginWithFacebookButton.setImage(viewModel.loginWithFacebookButtonImage, for: .normal)
        haveAccountLabel.text = viewModel.haveAccountLabelText
        routeToSignUpButton.setTitle(viewModel.routeToSignUpButtonTitle, for: .normal)
        lineView.text = viewModel.lineViewText
    }

    func displayLoginResult(viewModel: Login.LoginData.ViewModel) {
        switch viewModel.authResult {
        case .success:
            print("Success")
        case .failure(error: let error):
            processError(error: error)
        }
    }
}
