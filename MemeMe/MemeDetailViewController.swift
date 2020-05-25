//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/25/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    // Propertie
    var meme:Meme?
    var memeIndex:Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memeImageView.image = meme?.memedImage
    }
    
    
    //MARK: IBActions
    @IBAction func editButtonAction(_ sender: Any) {
    }
    

}
