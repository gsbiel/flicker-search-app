//
//  FlickerCollectionView.swift
//  flicker-search
//
//  Created by user164622 on 2/18/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit

class FlickerCollectionView: UIView {
    
    private lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.width*0.45)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionVC = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        collectionVC.translatesAutoresizingMaskIntoConstraints = false
        collectionVC.backgroundColor = .white
        collectionVC.register(FlickrCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionVC.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        return collectionVC
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(menuBar)
        self.addSubview(collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        //MenuBar
        menuBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}

class FlickrCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(imageView)
        setupLayout()
    }
    
    private func setupLayout() {
        // imageView
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
}
