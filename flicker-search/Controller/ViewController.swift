//
//  ViewController.swift
//  flicker-search
//
//  Created by user164622 on 2/18/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    private var flickerView: FlickerCollectionView? = nil
    
    private let menuImagesName: [String] = ["home","popular","feed","user"]
    
    private let collectionViewCellId: String =  "collectionViewCell"
    
    private var photosURLArray: [String]? {
        didSet{
            flickerView!.collectionView.reloadData()
        }
    }
    
    private let settingsLauncher = SettingsLauncher()
    
    private var menuBar: MenuBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //navigationController?.hidesBarsOnSwipe = true
    
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }
        
        let navBarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height))
        navBarTitleLabel.text = "Flicker Search"
        navBarTitleLabel.textColor = .white
        navBarTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        navBar.topItem?.titleView = navBarTitleLabel
        //navBar.topItem?.title = "Flicker Search"
        navBar.barTintColor = .red
        //navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        setNavBarButtons()
    
        flickerView = FlickerCollectionView(frame: UIScreen.main.bounds)
        menuBar = flickerView!.menuBar
        
        flickerView!.collectionView.dataSource = self
        flickerView!.collectionView.delegate = self
        menuBar?.delegate = self
        menuBar?.dataSource = self
        settingsLauncher.delegate = self
        
        self.view.addSubview(flickerView!)
        
        let initialIndexPath = IndexPath(item: 0, section: 0)
        menuBar?.selectItem(atIndexPath: initialIndexPath)
        
        FlickrAPI.getPhotoURL { (URLArray) in
            if let URLs = URLArray["success"] {
                self.photosURLArray = URLs
            }else{
                print("Erro!\(URLArray["error"]?[0])")
            }
        }
        
        
    }
    
    private func setNavBarButtons() {
        let searchButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchButton))
        searchButtonItem.tintColor = .white
        
        //        let dotMenuImage = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        //        let dotMenuButtonItem = UIBarButtonItem(image: dotMenuImage, style: .plain, target: self, action: #selector(handleDotMenuButton))
        let dotMenuButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(handleDotMenuButton))
        dotMenuButtonItem.tintColor = .white
        
        navigationItem.rightBarButtonItems = [dotMenuButtonItem, searchButtonItem]
    }
    
    @objc private func handleSearchButton() {
        print("Search Pressed!")
    }
    
    @objc private func handleDotMenuButton() {
        print("Open Menu!")
        settingsLauncher.showBlackView()
    }
}


// MARK: - CollectionView Delegate and DataSource Protocols

extension ViewController: UICollectionViewDelegateFlowLayout {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("Will end dragging")
//        print(targetContentOffset.pointee.x)
//        print(self.view.bounds.width)
        let index = Int(targetContentOffset.pointee.x/self.view.bounds.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar?.selectItem(atIndexPath: indexPath)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.photosURLArray?.count ?? 0
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colors = [UIColor.blue, UIColor.gray, UIColor.yellow, UIColor.orange]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! FlickrCollectionViewCell
        
        cell.backgroundColor = colors[indexPath.item]
//
//        if let photoURL = self.photosURLArray?[indexPath.item] {
//            cell.imageView.sd_setImage(with: URL(string: photoURL))
//            cell.backgroundColor = .red
//        }else {
//            cell.backgroundColor = .black
//        }
        
        return cell
    }
}

// MARK: - Settings Launcher Protocol
extension ViewController: SettingsLauncherProtocol {
    func didSelectSettingItem(item: K.SettingItems) {
        if item == K.SettingItems.Settings {
            let settingsVC = SettingsViewController()
            navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
}

// MARK: - MenuBar Delegate and DataSource Protocols

extension ViewController: MenuBarDelegate {
    func didSelectMenuBarItem(menuBar: MenuBar, atIndexPath indexPath: IndexPath) {
        flickerView?.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        menuBar.moveHorizontalBar(toIndexPath: indexPath.item)
    }
}

extension ViewController: MenuBarDataSource {
    
    func MenuBarCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuImagesName.count
    }

    func MenuBarCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: self.menuImagesName[indexPath.item])!.withRenderingMode(.alwaysTemplate)
        cell.tintColor = #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
        return cell
    }
    
    func MenuBarCollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4.0 , height: collectionView.bounds.height)
    }
    
    func MenuBarcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}


