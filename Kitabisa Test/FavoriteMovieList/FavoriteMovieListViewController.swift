//
//  FavoriteMovieListViewController.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class FavoriteMovieListViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: FavoriteMovieListPresenterInterface!
    
    lazy var viewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.backgroundColor = .systemGroupedBackground
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var data: [MovieModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layoutFrameGuide = view.layoutGuide.layoutFrame
        collectionView.frame = layoutFrameGuide
    }
    
    func setupCollectionView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
	
}

// MARK: - Extensions -

extension FavoriteMovieListViewController: FavoriteMovieListViewInterface {
    func showData(model: [MovieModel]) {
        data = model
    }
}

extension FavoriteMovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemCollectionView(index: indexPath.item)
    }
}

extension FavoriteMovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension FavoriteMovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.bindModel(data?[indexPath.item])
        return cell
    }
}
