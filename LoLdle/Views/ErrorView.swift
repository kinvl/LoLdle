//
//  ErrorView.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 15/10/2022.
//

import UIKit
import Lottie
import SnapKit

private struct Style {
    static let animationWidthHeight = 300
    static let backgroundOpacity = 0.5
}

final class ErrorView: UIView {
    private let overlayView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let animationView: LottieAnimationView = {
        let animation = LottieAnimation.filepath(R.file.errorJson()?.path ?? "")
        let animationView = LottieAnimationView(animation: animation)
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.beaufortW01Regular(size: 24)
        label.textColor = R.color.text()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
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
    func configure(withError error: LoLdleError) {
        errorLabel.text = error.description
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Spacing.Vertical.default)
            make.centerX.equalToSuperview()
            make.width.equalTo(Style.animationWidthHeight)
            make.height.equalTo(Style.animationWidthHeight)
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        overlayView.contentView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(Spacing.Vertical.default)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
        }
    }
}
