//
//  LineView.swift
//  BalancedDiet
//
//  Created by Yan Pepik on 13.04.22.
//

import UIKit
import SnapKit

final class LineView: UIView {
    // MARK: - Nested Types
    private enum Constants {
        static let lineHeight: CGFloat = 2
    }
    
    // MARK: - Properties
    var text: String = String.empty {
        didSet {
            textLabel.text = text
        }
    }
    
    // MARK: - UI Properties
    private let leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let textLabel = UILabel()

    private let rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    // MARK: - Initialiaztion
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(leftLine)
        addSubview(textLabel)
        addSubview(rightLine)
    }

    private func setupLayout() {
        leftLine.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.trailing.equalTo(textLabel.snp.leading).offset(-2)
            $0.height.equalTo(Constants.lineHeight)
            $0.centerY.equalToSuperview()
        }

        rightLine.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.leading.equalTo(textLabel.snp.trailing).offset(2)
            $0.height.equalTo(Constants.lineHeight)
            $0.centerY.equalToSuperview()
        }

        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
