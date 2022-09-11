//
//  ActivityOverlay.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 13/09/2022.
//

import UIKit
import SnapKit

private struct Style {
    static let indicatorContainerWidthMultiplier = 0.17
}

class ActivityOverlay: UIView {
    private let overlayView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    private let indicatorContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setup()
        indicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Private
    private func setup() {
        addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.contentView.addSubview(indicatorContainerView)
        indicatorContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Style.indicatorContainerWidthMultiplier)
            make.height.equalTo(indicatorContainerView.snp.width)
        }
        
        indicatorContainerView.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
