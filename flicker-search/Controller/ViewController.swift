//
//  ViewController.swift
//  flicker-search
//
//  Created by user164622 on 2/18/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }
        
        navBar.topItem?.title = "Flicker Search"
        navBar.barTintColor = #colorLiteral(red: 0.7235401308, green: 0.9265289656, blue: 1, alpha: 1)
        navBar.tintColor = #colorLiteral(red: 0.5413247865, green: 0.6131889538, blue: 1, alpha: 1)
        
        let flickerView = FlickerCollectionView(frame: UIScreen.main.bounds)
        
        flickerView.collectionView.dataSource = self
        flickerView.collectionView.delegate = self
        
        self.view.addSubview(flickerView)
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
        print("Data Source: Fui chamado!")
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}


