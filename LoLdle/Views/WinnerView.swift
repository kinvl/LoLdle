//
//  WinnerView.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 15/10/2022.
//

import UIKit
import Lottie
import SnapKit

private struct Style {
    static let championIconWidthHeightMultiplier = 2.5
    static let backgroundOpacity = 0.5
    static let screenWidth = UIScreen.main.bounds.width
}

final class WinnerView: UIView {
    private let overlayView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let animationView: LottieAnimationView = {
        let animation = LottieAnimation.filepath(R.file.congratulationsJson()?.path ?? "")
        let animationView = LottieAnimationView(animation: animation)
        animationView.isUserInteractionEnabled = false
        animationView.contentMode = .scaleToFill
        animationView.respectAnimationFrameRate = true
        return animationView
    }()
    
    private let congratulationsLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.beaufortBold(size: 42)
        label.text = R.string.localizable.winner_congratulations()
        label.textColor = R.color.text()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    private let championIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let championNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.beaufortW01Regular(size: 28)
        label.textColor = R.color.text()
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let numberOfGuessesLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.beaufortW01Regular(size: 18)
        label.textColor = R.color.text()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Internal
    func configureWith(numberOfGuesses: Int, icon: UIImage?, name: String?) {
        numberOfGuessesLabel.text = numberOfGuesses > 1
                                        ? R.string.localizable.winner_number_of_guesses(numberOfGuesses.title)
                                        : R.string.localizable.winner_first_try()
        championIconView.image = icon
        championNameLabel.text = name
    }
    
    func playAnimation() {
        animationView.play()
    }
    
    // MARK: - Private
    private func setup() {
        backgroundColor = .black.withAlphaComponent(Style.backgroundOpacity)
        
        addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.contentView.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        overlayView.contentView.addSubview(congratulationsLabel)
        congratulationsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Spacing.Vertical.big)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
        }
        
        overlayView.contentView.addSubview(championIconView)
        championIconView.snp.makeConstraints { make in
            make.top.equalTo(congratulationsLabel.snp.bottom).offset(Spacing.Vertical.default)
            make.width.height.equalTo(Style.screenWidth / Style.championIconWidthHeightMultiplier)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        overlayView.contentView.addSubview(championNameLabel)
        championNameLabel.snp.makeConstraints { make in
            make.top.equalTo(championIconView.snp.bottom).offset(Spacing.Vertical.small)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
        }
        
        overlayView.contentView.addSubview(numberOfGuessesLabel)
        numberOfGuessesLabel.snp.makeConstraints { make in
            make.top.equalTo(championNameLabel.snp.bottom).offset(Spacing.Vertical.medium)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
        }
    }
}
