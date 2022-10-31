//
//  AboutView.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import UIKit

final class AboutView: UIView {
    private let legalNotice: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.legal_notice()
        label.font = R.font.beaufortW01Regular(size: 20)
        label.textColor = R.color.text()
        label.numberOfLines = 0
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5.withAlphaComponent(0.5)
        return view
    }()
    
    private let howToPlayHeader: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.how_to_play_header()
        label.font = R.font.beaufortBold(size: 32)
        label.textColor = R.color.text()
        label.numberOfLines = 1
        return label
    }()
    
    private let howToPlayDetails: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: R.string.localizable.how_to_play_details())
        label.numberOfLines = 0
        label.textColor = R.color.text()
        label.font = R.font.beaufortW01Regular(size: 18)
        
        let greenAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: R.color.correct()!]
        attributedString.addAttributes(greenAttributes, range: NSRange(location: 166, length: 16))
        
        let orangeAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: R.color.partial()!]
        attributedString.addAttributes(orangeAttributes, range: NSRange(location: 209, length: 17))
        
        let redAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: R.color.incorrect()!]
        attributedString.addAttributes(redAttributes, range: NSRange(location: 255, length: 14))
        
        label.attributedText = attributedString
        
        return label
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.exit_button(), for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Private
    private func setup() {
        backgroundColor = R.color.background()
        
        addSubview(legalNotice)
        legalNotice.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacing.Vertical.default)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.big)
            make.top.equalTo(legalNotice.snp.bottom).offset(Spacing.Vertical.medium)
        }
        
        addSubview(howToPlayHeader)
        howToPlayHeader.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Spacing.Horizontal.default)
            make.top.equalTo(separatorView.snp.bottom).offset(Spacing.Vertical.medium)
        }
        
        addSubview(howToPlayDetails)
        howToPlayDetails.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
            make.top.equalTo(howToPlayHeader.snp.bottom).offset(Spacing.Vertical.medium)
        }
        
        addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Spacing.Vertical.big)
            make.centerX.equalToSuperview()
        }
    }
}
