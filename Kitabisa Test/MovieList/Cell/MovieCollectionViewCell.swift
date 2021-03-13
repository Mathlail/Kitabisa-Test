//
//  MovieCollectionViewCell.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var movieCardView: MovieCardView = {
        let imageView = MovieCardView(isDetailPage: false)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieCardView.prepareForReuse()
    }
    
    func setupViews(){
        contentView.addSubview(movieCardView)
        
        NSLayoutConstraint.activate([
            movieCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func bindModel(_ model: MovieModel?) {
        movieCardView.bindModel(model)
    }
}
