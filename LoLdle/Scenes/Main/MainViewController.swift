//
//  MainViewController.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 17/08/2022.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: BaseViewController<MainView> {
    private let viewModel: MainViewModeling
    private let router: MainRouting
    
    // MARK: - Initialization
    init(viewModel: MainViewModeling, router: MainRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nil
        setupRx()
        checkDataCompatibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private
    private func setupRx() {
        disposeBag.insert([
            castView.championChallengeButton.rx.tap.bind { [weak self] _ in
                Analytics.shared.trackChampionChallengeTapped()
                self?.router.presentChampionChallenge(from: self?.navigationController)
            }
        ])
    }
    
    private func checkDataCompatibility() {
        indicateProgress()
        viewModel.checkDataCompatibility()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] in
                self?.stopIndicatingProgress()
            } onError: { [weak self] error in
                self?.stopIndicatingProgress()
                self?.presentErrorView(error: LoLdleError(error: error))
            }.disposed(by: disposeBag)
    }
}
