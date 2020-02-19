//
//  MenuBar.swift
//  flicker-search
//
//  Created by user164622 on 2/19/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
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
        self.addSubview(viewContainer)
    }
    
    private func setupLayout() {
        // viewContainer
        viewContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
