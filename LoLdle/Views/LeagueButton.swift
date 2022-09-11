//
//  LeagueButton.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 15/09/2022.
//

import UIKit
import SnapKit

class LeagueButton: UIButton {
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.league_button_background()
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel?.alpha = isHighlighted ? 0.3 : 1.0
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundView.image = isEnabled
                ? R.image.league_button_background()
                : R.image.league_button_background_disabled()
        }
    }
    
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
        titleLabel?.font = R.font.beaufortW01Regular(size: 22)
        
        insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
