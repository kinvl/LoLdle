//
//  StringChallengeCell.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 20/09/2022.
//

import UIKit

final class StringChallengeCell: UITableViewCell {
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.layer.shadowRadius = 5
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 0, height: 1)
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: - Internal
    func configureWith<T: Titleable>(answer: Answer, details: T) {
        backgroundColor = answer.color
        detailsLabel.text = details.title
    }
    
    func configureWith<T: Titleable>(answer: Answer, details: [T]) {
        backgroundColor = answer.color
        detailsLabel.text = details.joinTitles(separator: ", ")
    }
    
    // MARK: - Private
    private func setup() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        
        addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}
