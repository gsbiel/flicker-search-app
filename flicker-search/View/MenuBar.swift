//
//  MenuBar.swift
//  flicker-search
//
//  Created by user164622 on 2/19/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    private let collectionViewCellId: String =  "collectionViewCell"
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .red
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        setupView()
    }
    
    private func setupView() {
        viewContainer.addSubview(collectionView)
        self.addSubview(viewContainer)
        setupLayout()
    }
    
    private func setupLayout() {
        // viewContainer
        viewContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // collectionView
        collectionView.topAnchor.constraint(equalTo: viewContainer.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width/4.0 , height: self.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
