//
//  ImageChallengeCell.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 20/09/2022.
//

import UIKit

final class ImageChallengeCell: UITableViewCell {
    private let detailsImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
    func configureWith(icon: UIImage?) {
        detailsImage.image = icon
    }
    
    // MARK: - Private
    private func setup() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        
        addSubview(detailsImage)
        detailsImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
