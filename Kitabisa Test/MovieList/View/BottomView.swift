//
//  BottomView.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import UIKit

class BottomView: UIView {
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var popularButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Popular", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.tag = 0
        return button
    }()
    
    lazy var upcomingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Upcoming", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.tag = 1
        return button
    }()
    
    lazy var topRatedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Top Rated", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.tag = 2
        return button
    }()
    
    lazy var nowPlayingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Now Playing", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.tag = 3
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeView))
        addGestureRecognizer(tapGesture)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(menuView)
        menuView.addSubview(popularButton)
        menuView.addSubview(upcomingButton)
        menuView.addSubview(topRatedButton)
        menuView.addSubview(nowPlayingButton)
        
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: bottomAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 250),
            
            popularButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            popularButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            popularButton.topAnchor.constraint(equalTo: menuView.topAnchor),
            popularButton.heightAnchor.constraint(equalToConstant: 50),
            
            upcomingButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            upcomingButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            upcomingButton.topAnchor.constraint(equalTo: popularButton.bottomAnchor),
            upcomingButton.heightAnchor.constraint(equalToConstant: 50),
            
            topRatedButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            topRatedButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            topRatedButton.topAnchor.constraint(equalTo: upcomingButton.bottomAnchor),
            topRatedButton.heightAnchor.constraint(equalToConstant: 50),
            
            nowPlayingButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            nowPlayingButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            nowPlayingButton.topAnchor.constraint(equalTo: topRatedButton.bottomAnchor),
            nowPlayingButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func showView() {
        guard let window = UIApplication.shared.windows.last else { return }
        self.frame = window.frame
        window.addSubview(self)
    }
    
    @objc func removeView() {
        guard let window = UIApplication.shared.windows.last else { return }
        if self.isDescendant(of: window) {
            self.removeFromSuperview()
        }
    }
}
