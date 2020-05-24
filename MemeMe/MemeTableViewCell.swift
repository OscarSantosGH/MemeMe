//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/24/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    // initialize the cell with a Meme object
    func set(with meme:Meme) {
        memeImageView.image = meme.memedImage
        topLabel.text = meme.topText
        bottomLabel.text = meme.bottomText
    }

}
