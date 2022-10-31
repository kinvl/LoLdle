//
//  ChallengeView.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 16/09/2022.
//

import Foundation
import UIKit
import SnapKit
import KeyboardLayoutGuide
import AutocompleteField
import Lottie

final class ChallengeView: UIView {
    private let backgroundImage = UIImageView(image: R.image.background())
    
    let navigationBarAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = R.color.background()
        return appearance
    }()
    
    let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: -25, y: 0, width: 45, height: 45))
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        let image = R.image.back_arrow()
        button.setImage(image, for: .normal)
        return button
    }()
    
    let navigationBarLogo: UIImageView = {
        let imageView = UIImageView(image: R.image.logo())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ChampionChallengeCell.self, forCellReuseIdentifier: ChampionChallengeCell.identifier)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.keyboardDismissMode = .interactive
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let answerTextField: AutocompleteField = {
        let textField = AutocompleteField()
        textField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.answer_textfield_placeholder(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.backgroundColor = R.color.background()
        textField.textColor = R.color.text()
        textField.suggestionColor = .systemGray
        textField.tintColor = R.color.accentColor()
        textField.borderStyle = .bezel
        textField.layer.borderColor = R.color.accentColor()?.cgColor
        textField.layer.borderWidth = 2
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.smartQuotesType = .no
        textField.returnKeyType = .done
        return textField
    }()
    
    let answerButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = R.image.answer_arrow()
        button.imageView?.tintColor = R.color.accentColor()
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let winnerView: WinnerView = {
        let view = WinnerView()
        view.alpha = 0
        return view
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Internal
    func setup(withNavigationBar navigationBar: UINavigationBar?) {
        setupNavigationBar(navigationBar)
        
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(answerButton)
        answerButton.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).multipliedBy(0.13)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-Spacing.Vertical.tiny)
            make.trailing.equalToSuperview()
        }
        
        addSubview(answerTextField)
        answerTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(answerButton.snp.leading).inset(-5)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).inset(-Spacing.Vertical.tiny)
            make.height.equalTo(answerButton.snp.height)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(Spacing.Horizontal.default)
            make.bottom.equalTo(answerTextField.snp.top).offset(-Spacing.Vertical.tiny)
        }
    }
    
    func configureWith(suggestions: [String]) {
        answerTextField.suggestions = suggestions
    }
    
    func addWinnerView(info: CompletedChallengeInfo) {
        winnerView.configureWith(numberOfGuesses: info.numberOfGuesses, icon: info.icon, name: info.name)
        
        addSubview(winnerView)
        winnerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseInOut) { [weak self] in
            self?.winnerView.alpha = 1
        } completion: { isCompleted in
            if isCompleted {
                self.winnerView.playAnimation()
            }
        }
    }
    
    func reloadTableView() {
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
    // MARK: - Private
    private func setupNavigationBar(_ navigationBar: UINavigationBar?) {
        navigationBar?.prefersLargeTitles = false
        navigationBar?.standardAppearance = navigationBarAppearance
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        
        let scale: CGFloat = 512 / 209 // Logo image is 512x209 pixels
        let height = navigationBar?.frame.height ?? 0
        let width = height * scale
        
        navigationBarLogo.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
}
