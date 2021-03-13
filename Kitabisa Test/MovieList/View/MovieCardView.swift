//
//  MovieCardView.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

class MovieCardView: UIView {

    lazy var movieImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var synopsisLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "heart-filled-red"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
    }
    
    convenience init(isDetailPage: Bool) {
        self.init()
        setupViews(isDetailPage: isDetailPage)
        if isDetailPage { setupFavoriteButton() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepareForReuse() {
        movieImageView.image = nil
        releaseDateLabel.text = nil
        synopsisLabel.text = nil
    }
    
    func setupViews(isDetailPage: Bool){
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(synopsisLabel)
        if isDetailPage { addSubview(favoriteButton) }
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            movieImageView.widthAnchor.constraint(equalToConstant: 120),
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: isDetailPage ?  favoriteButton.leadingAnchor : trailingAnchor, constant: -20),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            synopsisLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            synopsisLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 15),
            synopsisLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func setupFavoriteButton() {
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: synopsisLabel.trailingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func bindModel(_ model: MovieModel?) {
        setupMovieImage(model?.image)
        titleLabel.text = model?.title
        releaseDateLabel.text = convertDateFormat(inputDate: model?.releaseDate)
        synopsisLabel.text = model?.synopsis
    }
    
    func setupMovieImage(_ image: String?){
        guard let image = image else { return }
        let url = "https://image.tmdb.org/t/p/w500/\(image)"
        movieImageView.downloadImageFrom(withUrl: url)
    }
    
    func convertDateFormat(inputDate: String?) -> String? {
        guard let inputDate = inputDate else { return nil }
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let oldDate = olDateFormatter.date(from: inputDate)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return convertDateFormatter.string(from: oldDate!)
    }

}
