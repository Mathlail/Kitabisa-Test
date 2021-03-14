//
//  MovieListViewController.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class MovieListViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: MovieListPresenterInterface!
    
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
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Category", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didSelectCategoryButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.popularButton.addTarget(self, action: #selector(didSelectMovieType(_:)), for: .touchUpInside)
        view.upcomingButton.addTarget(self, action: #selector(didSelectMovieType(_:)), for: .touchUpInside)
        view.topRatedButton.addTarget(self, action: #selector(didSelectMovieType(_:)), for: .touchUpInside)
        view.nowPlayingButton.addTarget(self, action: #selector(didSelectMovieType(_:)), for: .touchUpInside)
        return view
    }()
    
    var data: [MovieModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath,
                                                 at: .top,
                                                 animated: true)
            }
            
        }
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCategoryButton()
        presenter.viewDidLoad()
        title = "The Movies"
        navigationItem.largeTitleDisplayMode = .never
        setupRightNavigationBar(withImage: #imageLiteral(resourceName: "heart-filled-black"))
    }
    
    func setupRightNavigationBar(withImage image: UIImage!) {
        let barButtonItem = UIBarButtonItem(image: image.withTintColor(.black, renderingMode: .alwaysOriginal),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapRightBarButtonItem(_:)))
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func setupCategoryButton() {
        view.addSubview(categoryButton)
        NSLayoutConstraint.activate([
            categoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layoutFrameGuide = view.layoutGuide.layoutFrame
        collectionView.frame = layoutFrameGuide
        collectionView.contentInset = UIEdgeInsets(top: collectionView.contentInset.top, left: collectionView.contentInset.left, bottom: 50, right: collectionView.contentInset.right)
    }
    
    @objc func didSelectCategoryButton(_ sender: UIButton) {
        bottomView.showView()
    }
    
    @objc func didTapRightBarButtonItem(_ sender: UIButton) {
        presenter.openFavorites()
    }
    
    @objc func didSelectMovieType(_ sender: UIButton) {
        presenter.movieTypeDidChange(tag: sender.tag)
        bottomView.removeView()
    }
	
}

// MARK: - Extensions -

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.bindModel(data?[indexPath.item])
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemCollectionView(index: indexPath.item)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.screenWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension MovieListViewController: MovieListViewInterface {
    func showData<T>(_ data: [T]) where T : Decodable, T : Encodable {
        self.data = data as? [MovieModel]
    }
}
