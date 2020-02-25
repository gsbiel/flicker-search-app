//
//  SettingsViewController.swift
//  flicker-search
//
//  Created by user164622 on 2/25/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation Controller does not exist.")
        }
        
        self.view.backgroundColor = UIColor.lightGray
        navigationController?.navigationItem.title = "Settings"
        
        navBar.tintColor = .white
        
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white
        ]
        
        navBar.titleTextAttributes = attributes
    }
}
