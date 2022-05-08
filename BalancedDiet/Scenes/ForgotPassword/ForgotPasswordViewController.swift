//
//  ForgotPasswordViewController.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 25.04.22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

final class ForgotPasswordViewController: UIViewController {
    // MARK: - Nested Types
    private enum Constants {
        static let fontSize: CGFloat = 30
        static let inset: CGFloat = 16
        static let topOffset: CGFloat = 20
        static let multiplier: CGFloat = 0.03
        static let bottomOffset: CGFloat = 38
    }

    // MARK: - Properties
    private let interactor: ForgotPasswordBusinessLogic
    private let router: ForgotPasswordRoutingLogic

    // MARK: - UI Properties
    private let emailTextField = TextFieldView(style: .email)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsSemiBold(size: Constants.fontSize)
        return label
    }()

    private var loginLinkButton: Button = {
        let button = Button()
        button.addTarget(ForgotPasswordViewController.self, action: #selector( loginButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization
    init(interactor: ForgotPasswordBusinessLogic, router: ForgotPasswordRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in ForgotPasswordViewController")
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
    }

    private func setupSubviews() {
        view.addSubviews( titleLabel, emailTextField, loginLinkButton)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(Constants.inset)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(view.frame.height * Constants.multiplier)
        }

        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.inset)
            $0.top.equalTo( titleLabel.snp.bottom).offset(Constants.topOffset)
        }

        loginLinkButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.inset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.bottomOffset)
        }
    }

    //MARK: - Actions
    @objc private func  loginButtonPressed() {
        let email = emailTextField.getCurrentTextFieldText()
        interactor.resetPassword(request: ForgotPassword.ResetPasswordData.Request(email: email))
    }

    // MARK: - Interactor Methods
    func fetchInitialData() {
        let request = ForgotPassword.InitialData.Request()
        interactor.fetchInitialData(request: request)
    }
}

// MARK: - ForgotPasswordDisplayLogic
extension ForgotPasswordViewController: ForgotPasswordDisplayLogic {
    func displayInititalData(viewModel: ForgotPassword.InitialData.ViewModel) {
        titleLabel.text = viewModel.titleText
        loginLinkButton.setTitle(viewModel.loginLinkButtonTitle, for: .normal)
    }

    func displayResetPasswordResult(viewModel: ForgotPassword.ResetPasswordData.ViewModel) {
        switch viewModel.authResult {
        case .success:
            print("Success")
        case .failure(error: let error):
            print(error)
        }
    }
}
