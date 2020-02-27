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
    
        flickerView = FlickerCollectionView(frame: UIScreen.main.bounds)
        
        flickerView!.collectionView.dataSource = self
        flickerView!.collectionView.delegate = self
    
        menuBar = flickerView?.menuBar
        
        self.view.addSubview(flickerView!)
        
        FlickrAPI.getPhotoURL { (URLArray) in
            if let URLs = URLArray["success"] {
                self.photosURLArray = URLs
            }else{
                print("Erro!\(URLArray["error"]?[0])")
            }
        }
        
        setNavBarButtons()
        
        settingsLauncher.delegate = self
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


extension ViewController: UICollectionViewDelegateFlowLayout {

    // Define o tamanho de um item em uma dada celula
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("Fui chamado!")
//        let size = CGSize(width: collectionViewLayout.collectionViewContentSize.width, height: collectionViewLayout.collectionViewContentSize.height)
//
//        return size
//    }
    
    
    // Definir as margens para serem aplicadas ao conteudo de uma determinada secao
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//    }
    
    // Definir o espacamento entre linhas ou colunas adjacentes de uma secao
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        <#code#>
//    }
    
    // Definir o espacamento entre itens sucessivos de uma secao. (seja em uma coluna ou linha)
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        <#code#>
//    }
    
    // Definir o tamanho do header em uma dada secao
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        let offset = scrollView.contentOffset.x / CGFloat(4.0)
        menuBar?.moveHorizontalBar(toOffset: offset)
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

extension ViewController: SettingsLauncherProtocol {
    func didSelectSettingItem(item: K.SettingItems) {
        if item == K.SettingItems.Settings {
            let settingsVC = SettingsViewController()
            navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
}


