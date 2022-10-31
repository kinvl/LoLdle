//
//  MainView.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 09/09/2022.
//

import Foundation
import UIKit
import SnapKit

final class MainView: UIView {
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.background()
        return imageView
    }()
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.logo()
        return imageView
    }()
    
    let championChallengeButton: LeagueButton = {
        let button = LeagueButton()
        button.setTitleColor(R.color.text(), for: .normal)
        button.setTitle(R.string.localizable.challenge_button_champion_title(), for: .normal)
        return button
    }()
    
    let quoteChallengeButton: LeagueButton = {
        let button = LeagueButton()
        button.setTitleColor(R.color.text(), for: .normal)
        button.setTitle(R.string.localizable.challenge_button_quote_title(), for: .normal)
        button.isEnabled = false
        return button
    }()
    
    let abilityChallengeButton: LeagueButton = {
        let button = LeagueButton()
        button.setTitleColor(R.color.text(), for: .normal)
        button.setTitle(R.string.localizable.challenge_button_ability_title(), for: .normal)
        button.isEnabled = false
        return button
    }()
    
    let splashChallengeButton: LeagueButton = {
        let button = LeagueButton()
        button.setTitleColor(R.color.text(), for: .normal)
        button.setTitle(R.string.localizable.challenge_button_splash_title(), for: .normal)
        button.isEnabled = false
        return button
    }()
    
    let aboutButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.about_icon(), for: .normal)
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
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacing.Vertical.default)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
        }
        
        addSubview(championChallengeButton)
        championChallengeButton.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(Spacing.Vertical.small)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.mainButton)
            make.height.equalTo(Height.mainButton)
        }
        
        addSubview(quoteChallengeButton)
        quoteChallengeButton.snp.makeConstraints { make in
            make.top.equalTo(championChallengeButton.snp.bottom).offset(Spacing.Vertical.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.mainButton)
            make.height.equalTo(Height.mainButton)
        }
        
        addSubview(abilityChallengeButton)
        abilityChallengeButton.snp.makeConstraints { make in
            make.top.equalTo(quoteChallengeButton.snp.bottom).offset(Spacing.Vertical.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.mainButton)
            make.height.equalTo(Height.mainButton)
        }
        
        addSubview(splashChallengeButton)
        splashChallengeButton.snp.makeConstraints { make in
            make.top.equalTo(abilityChallengeButton.snp.bottom).offset(Spacing.Vertical.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.mainButton)
            make.height.equalTo(Height.mainButton)
        }
        
        addSubview(aboutButton)
        aboutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Spacing.Vertical.big)
            make.centerX.equalToSuperview()
        }
    }
}
