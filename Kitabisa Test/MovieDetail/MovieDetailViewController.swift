//
//  MovieDetailViewController.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: MovieDetailPresenterInterface!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var movieCardView: MovieCardView = {
        let view = MovieCardView(isDetailPage: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.favoriteButton.addTarget(self, action: #selector(didSelectFavoriteButton(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var viewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var data: [ReviewModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width, height: 230 + 180)
    }
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(movieCardView)
        scrollView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            movieCardView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieCardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            movieCardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            movieCardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            movieCardView.heightAnchor.constraint(equalToConstant: 230),
            
            collectionView.topAnchor.constraint(equalTo: movieCardView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 160),
        ])
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    @objc func didSelectFavoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        presenter.configureToLocalData(isSelected: sender.isSelected)
    }
	
}

// MARK: - Extensions -

extension MovieDetailViewController: MovieDetailViewInterface {
    
    func setupMovieCardView(model: MovieModel) {
        movieCardView.bindModel(model)
        title = model.title
    }
    
    func showReviews(model: [ReviewModel]) {
        data = model
    }
    
    func setupFavoriteButton(isSelected: Bool) {
        movieCardView.favoriteButton.isSelected = isSelected
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReviewCollectionViewCell
        cell.bindModel(data?[indexPath.item])
        return cell
    }
    
    
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.screenWidth * 0.7, height: 140)
    }
}

