//
//  ReviewCollectionViewCell.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(reviewLabel)
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            reviewLabel.topAnchor.constraint(equalTo: fullNameLabel.topAnchor, constant: 20),
            reviewLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
        ])
    }
    
    func bindModel(_ model: ReviewModel?) {
        fullNameLabel.text = model?.author
        reviewLabel.text = model?.content
    }
}
