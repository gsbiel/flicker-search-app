//
//  SettingsLauncher.swift
//  flicker-search
//
//  Created by user164622 on 2/24/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    private let cvHeight: CGFloat = CGFloat(400)
    
    private let cvItemsArray: [String] = [
        "Settings",
        "Terms and privacy policy",
        "Send feedback",
        "Help",
        "Switch account",
        "Cancel"
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if let viewBounds = self.delegate?.view.bounds {
            cv.frame = CGRect(x: 0, y: viewBounds.height, width: viewBounds.width, height: self.cvHeight)
            layout.itemSize = CGSize(width: viewBounds.width, height: 50)
        }
        cv.backgroundColor = .white
        cv.register(SettingsCell.self, forCellWithReuseIdentifier: "cvSettingsCell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        view.backgroundColor = .black
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissBlackView)))
        return view
    }()
    
    var delegate: ViewController? {
        didSet{
            delegate?.view.addSubview(self.blackView)
        }
    }

    override init() {
        super.init()
    }
    
    @objc private func handleDismissBlackView() {
        
        //A animacao abaixo e linear. Veja que na hora de exibir a collectionView eu usei uma animacao nao linear
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let viewBounds = self.delegate?.view.bounds {
                self.collectionView.frame = CGRect(x: 0, y: (viewBounds.height), width: viewBounds.width, height: self.cvHeight)
            }
        }
        
        collectionView.removeFromSuperview()
        
    }
    
    @objc func showBlackView(){
        delegate?.view.addSubview(collectionView)
        
        // Essa animacao e nao linear, ela comeca rapida e vai desacelerando.
        UIView.animate(withDuration: 0.85, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                if let viewBounds = self.delegate?.view.bounds {
                    self.collectionView.frame = CGRect(x: 0, y: (viewBounds.height - self.cvHeight), width: viewBounds.width, height: self.cvHeight)
                }
        }, completion: nil)
    }

}

extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cvItemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvSettingsCell", for: indexPath) as! SettingsCell
        cell.label.text = self.cvItemsArray[indexPath.item]
        return cell
    }
}

class SettingsCell: UICollectionViewCell {
    
    private lazy var icon: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .green
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
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
        self.addSubview(icon)
        self.addSubview(label)
        setupLayout()
    }
    
    private func setupLayout() {
        // icon
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        
        // label
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
