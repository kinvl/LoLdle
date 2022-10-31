//
//  ChallengeViewController.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 11/09/2022.
//

import Foundation
import UIKit
import RxSwift
import AutocompleteField

class ChallengeViewController: BaseViewController<ChallengeView>, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    private let viewModel: ChallengeViewModeling
    
    // MARK: - Initialization
    init(viewModel: ChallengeViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        castView.setup(withNavigationBar: navigationController?.navigationBar)
        viewModel.isTodaysAlreadyChallengeCompleted
            ? presentWinnerView()
            : prepare()
        setupNavigationBarItems()
        setupRx()
        
        castView.tableView.dataSource = self
        castView.tableView.delegate = self
        castView.answerTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Private
    private func setupNavigationBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: castView.backButton)
        navigationItem.titleView = castView.navigationBarLogo
    }
    
    private func setupRx() {
        disposeBag.insert([
            castView.backButton.rx.tap.bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            },
            castView.answerButton.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.textFieldShouldReturn(self.castView.answerTextField)
            },
            viewModel.suggestions.drive(castView.answerTextField.rx.suggestions)
        ])
    }
    
    private func prepare() {
        indicateProgress()
        viewModel.prepare()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] suggestions in
                self?.stopIndicatingProgress()
                self?.castView.configureWith(suggestions: suggestions)
            } onFailure: { [weak self] error in
                self?.stopIndicatingProgress()
                self?.presentErrorView(error: LoLdleError(error: error))
            }.disposed(by: disposeBag)
    }
    
    private func checkAnswer(_ championName: String) {
        let isCorrect = viewModel.isAnswerCorrect(championName)
        Analytics.shared.trackAnswerChecked(answerCorrect: isCorrect)
        castView.reloadTableView()
        if isCorrect {
            presentWinnerView()
        }
    }
    
    private func presentWinnerView() {
        self.dismissKeyboard()
        if let completedChallengeInfo = viewModel.completedChallengeInfo {
            castView.addWinnerView(info: completedChallengeInfo)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.guesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChampionChallengeCell.identifier, for: indexPath) as? ChampionChallengeCell else {
            return UITableViewCell()
        }
        
        cell.configureWith(model: viewModel.guesses[indexPath.row])
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    @discardableResult
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? AutocompleteField, let championName = textField.suggestion  else { return true }
        
        textField.text = nil
        checkAnswer(championName)
        
        return false
    }
}
