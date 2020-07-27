//
//  LastViewController.swift
//  MovieApp
//
//  Created by Pick Jobs on 7/25/20.
//  Copyright © 2020 Pick Jobs. All rights reserved.
//

import UIKit

protocol SelectedItems {
    var title2: String {get}
    var overview2: String {get}
}

class LastViewController: UIViewController{
    
    public var delegateNew: SelectedItems?
    
    //MARK: - Outlet Connections-
    
    @IBOutlet var originalTitle: UILabel!
    @IBOutlet var overView: UILabel!
    
    //MARK: - LifeCycle Functions-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let delegateNew = self.delegateNew {
            self.originalTitle.text = delegateNew.title2 //Adding delegateNew to property title2
        }
        
        if let delegateNew = self.delegateNew {
            self.overView.text = delegateNew.overview2 //Adding delegateNew to property overview2
        }
    }
}
