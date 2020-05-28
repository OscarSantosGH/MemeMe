//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/25/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, MemeCreatorViewControllerDelegate {
    
    
    //MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    // Property
    var meme:Meme?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memeImageView.image = meme?.memedImage
    }
    
    
    //MARK: - IBActions
    @IBAction func editButtonAction(_ sender: Any) {
        //performSegue(withIdentifier: "CreateMemeSegue", sender: nil)
        let memeCreatorViewController = storyboard?.instantiateViewController(withIdentifier: "MemeCreatorViewController") as! MemeCreatorViewController
        memeCreatorViewController.memeToEdit = meme
        memeCreatorViewController.isEditingMeme = true
        memeCreatorViewController.presentingDelegate = self
        present(memeCreatorViewController, animated: true)
    }
    
    func goToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }

}
