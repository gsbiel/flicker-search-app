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
    
    private let menuImagesName: [String] = ["home","popular","feed","user"]
    
    private var horizontalBarLeftLayoutConstraint: NSLayoutConstraint?
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .red
        collection.register(MenuCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var segmentBar: UIView = {
        let segment = UIView()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = UIColor.red
        return segment
    }()
    
    private lazy var currentItemBar: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.white
        return bar
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
        segmentBar.addSubview(currentItemBar)
        viewContainer.addSubview(segmentBar)
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
        //collectionView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        collectionView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor).isActive = true
        
        // segmentBar
        segmentBar.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        segmentBar.leftAnchor.constraint(equalTo: viewContainer.leftAnchor).isActive = true
        segmentBar.rightAnchor.constraint(equalTo: viewContainer.rightAnchor).isActive = true
        segmentBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // currentItemBar
        currentItemBar.topAnchor.constraint(equalTo: segmentBar.topAnchor).isActive = true
        currentItemBar.bottomAnchor.constraint(equalTo: segmentBar.bottomAnchor).isActive = true
        currentItemBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4).isActive = true
        horizontalBarLeftLayoutConstraint = currentItemBar.leftAnchor.constraint(equalTo: segmentBar.leftAnchor)
        horizontalBarLeftLayoutConstraint?.isActive = true
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: self.menuImagesName[indexPath.item])!.withRenderingMode(.alwaysTemplate)
        cell.tintColor = #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width/4.0 , height: self.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = UIScreen.main.bounds.width/4 * CGFloat(indexPath.item)
        self.horizontalBarLeftLayoutConstraint?.constant = x
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

class MenuCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //As variaveis sobrescritas abaixo pertencem a superclasse UICollectionViewCell e nos permite saber quando o usuario toca ou seleciona um dos itens do CollectioNView
    override var isHighlighted: Bool {
        didSet{
            imageView.tintColor = self.isHighlighted ? UIColor.white : #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = self.isSelected ? UIColor.white : #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(imageView)
        setupLayout()
    }
    
    private func setupLayout() {
        // ImageView
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
