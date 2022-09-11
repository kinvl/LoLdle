//
//  ChampionChallengeCell.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 20/09/2022.
//

import Foundation
import UIKit

typealias ChampionCellItemModel = (answer: ChampionAnswer, champion: Champion, icon: UIImage?)

private struct Style {
    static let cellWidthHeightDivider = 4.0
    static let stackViewSpacing = 5.0
    static let stackViewWidth = UIScreen.main.bounds.size.width - 2 * Spacing.Horizontal.default - 3 * Style.stackViewSpacing
}

final class ChampionChallengeCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let nameView: ImageChallengeCell = {
        let cell = ImageChallengeCell()
        return cell
    }()
    
    private let genderView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let positionView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let speciesView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let resourceView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let rangeTypeView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let regionView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let releaseDateView: StringChallengeCell = {
        let cell = StringChallengeCell()
        return cell
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Style.stackViewSpacing
        return stackView
    }()
    
    private let upperRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Style.stackViewSpacing
        return stackView
    }()
    
    private let bottomRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Style.stackViewSpacing
        return stackView
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
    func configureWith(model: ChampionCellItemModel) {
        nameView.configureWith(icon: model.icon)
        genderView.configureWith(answer: model.answer.gender, details: model.champion.gender)
        positionView.configureWith(answer: model.answer.position, details: model.champion.position)
        speciesView.configureWith(answer: model.answer.species, details: model.champion.species)
        resourceView.configureWith(answer: model.answer.resource, details: model.champion.resource)
        rangeTypeView.configureWith(answer: model.answer.rangeType, details: model.champion.rangeType)
        regionView.configureWith(answer: model.answer.region, details: model.champion.region)
        releaseDateView.configureWith(answer: model.answer.releaseYear, details: model.champion.releaseYear)
    }
    
    // MARK: - Private
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Spacing.Vertical.medium)
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Style.stackViewWidth / 2)
        }
        
        stackView.addArrangedSubview(upperRow)
        upperRow.addArrangedSubview(nameView)
        upperRow.addArrangedSubview(genderView)
        upperRow.addArrangedSubview(positionView)
        upperRow.addArrangedSubview(speciesView)
        
        stackView.addArrangedSubview(bottomRow)
        bottomRow.addArrangedSubview(resourceView)
        bottomRow.addArrangedSubview(rangeTypeView)
        bottomRow.addArrangedSubview(regionView)
        bottomRow.addArrangedSubview(releaseDateView)
        
        nameView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        genderView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        positionView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        speciesView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        resourceView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        rangeTypeView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        regionView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }

        releaseDateView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
            make.width.lessThanOrEqualTo(Style.stackViewWidth / Style.cellWidthHeightDivider)
        }
    }
}
