//
//  FlickerCollectionView.swift
//  flicker-search
//
//  Created by user164622 on 2/18/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit

class FlickerCollectionView: UIView {
    
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionVC = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        collectionVC.translatesAutoresizingMaskIntoConstraints = false
        collectionVC.backgroundColor = .white
        collectionVC.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
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
        self.addSubview(collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
