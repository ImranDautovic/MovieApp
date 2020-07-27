//
//  MainTableViewCell.swift
//  MovieApp
//
//  Created by Pick Jobs on 7/20/20.
//  Copyright © 2020 Pick Jobs. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections -
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var voteLabel:  UILabel!
    
    //MARK: - Functions -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - UI Settings -
    
    fileprivate func setupView(){
        self.selectionStyle = .none
        self.firstImageView.layer.cornerRadius = 15
        self.firstImageView.layer.masksToBounds = true
    }
}
