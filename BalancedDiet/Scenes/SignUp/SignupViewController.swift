//
//  SignupViewController.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 31.03.22.
//

import UIKit
import SnapKit

final class SignupViewController: UIViewController {
    // MARK: - Nested Types
    private enum Constants {
        static let height: CGFloat = 50
        static let fontSize: CGFloat = 30
        static let inset: CGFloat = 16
        static let multiplier: CGFloat = 0.01
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = 10
        static let verticalStackViewSpacing: CGFloat = 20
        static let horizontalStackViewSpacing: CGFloat = 2
    }
    
    // MARK: - Private properties
    private let interactor: SignupBusinessLogic
    private let router: SignupRoutingLogic
    
    // MARK: - UI Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let haveAccountLabel = UILabel()
    private let emailTextField = TextFieldView(style: .email)
    private let passwordTextField = TextFieldView(style: .password)
    private let repeatPasswordTextField = TextFieldView(style: .repeatPassword)
    private let userNameTextField = TextFieldView(style: .userName)
    private let signUpButton = Button()

    private let sceneNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsSemiBold(size: Constants.fontSize)
        return label
    }()

    private let routeToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        )
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalStackViewSpacing
        return stackView
    }()

    private lazy var haveAccountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [haveAccountLabel, routeToLoginButton])
        stackView.axis = .horizontal
        stackView.spacing = Constants.horizontalStackViewSpacing
        return stackView
    }()
    
    // MARK: - Initialization
    init(interactor: SignupBusinessLogic, router: SignupRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in SignUpViewController")
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
        scrollView.delaysContentTouches = false

        setupSubviews()
        setupLayout()
        setupActions()
        registerForKeybordNotifications()
        setupHideKeyboardOnTap()
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(sceneNameLabel, textFieldsStackView, signUpButton, haveAccountStackView)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height).priority(.low)
        }

        sceneNameLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(Constants.inset)
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(view.frame.height * Constants.multiplier)
        }

        textFieldsStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.inset)
            $0.top.equalTo(sceneNameLabel.snp.bottom).offset(Constants.topOffset)
        }

        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.inset)
            $0.bottom.equalTo(haveAccountStackView.snp.top).offset(-Constants.bottomOffset)
        }

        haveAccountStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-Constants.bottomOffset)
        }
    }

    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        routeToLoginButton.addTarget(self, action: #selector( routeToLoginPressed), for: .touchUpInside)
    }

    private func registerForKeybordNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    //MARK: - Actions
    @objc private func signUpPressed() {
    }

    @objc private func routeToLoginPressed() {
        router.routeToLogin()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = (notification as Notification).userInfo,
            let keyboardNSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let keyboardFrame = keyboardNSValue.cgRectValue
        scrollView.contentInset.bottom = keyboardFrame.size.height
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero
    }

    // MARK: - Interactor Methods
    func fetchInitialData() {
        let request = Signup.InitialData.Request()
        interactor.fetchInitialData(request: request)
    }
}

// MARK: - SignUpDisplayLogic
extension SignupViewController: SignupDisplayLogic {
    func displayInititalData(viewModel: Signup.InitialData.ViewModel) {
        sceneNameLabel.text = viewModel.sceneNameLabelText
        signUpButton.setTitle(viewModel.signUpButtonTitle, for: .normal)
        haveAccountLabel.text = viewModel.haveAccountLabelText
        routeToLoginButton.setTitle(viewModel.routeToLoginButtonTitle, for: .normal)
    }
}
