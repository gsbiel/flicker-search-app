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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }
        
        navBar.topItem?.title = "Flicker Search"
        navBar.barTintColor = .red
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        flickerView = FlickerCollectionView(frame: UIScreen.main.bounds)
        
        flickerView!.collectionView.dataSource = self
        flickerView!.collectionView.delegate = self
        self.view.addSubview(flickerView!)
        
        FlickrAPI.getPhotoURL { (URLArray) in
            if let URLs = URLArray["success"] {
                self.photosURLArray = URLs
            }else{
                print("Erro!\(URLArray["error"]?[0])")
            }
        }
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

}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosURLArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! FlickrCollectionViewCell
        
        if let photoURL = self.photosURLArray?[indexPath.item] {
            cell.imageView.sd_setImage(with: URL(string: photoURL))
            cell.backgroundColor = .red
        }else {
            cell.backgroundColor = .black
        }
        
        return cell
    }
}


