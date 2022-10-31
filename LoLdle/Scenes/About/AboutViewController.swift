//
//  AboutViewController.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import UIKit

class AboutViewController: BaseViewController<AboutView> {
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    // MARK: - Private
    private func setupRx() {
        castView.exitButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}
