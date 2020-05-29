//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/28/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var memeCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // computed property with all the memes from the memes array in appDelegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the dataSource of the collection to MemeCollectionViewController
        memeCollectionView.dataSource = self
        // Set the delegate of the collection to MemeCollectionViewController
        memeCollectionView.delegate = self
        
        configureFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCollectionView()
    }
    
    func configureFlowLayout(){
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func reloadCollectionView(){
        // reload the data of the tableView
        memeCollectionView.reloadData()
    }
    
    // MARK: IBAction
    @IBAction func createNewMeme(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateMemeSegue", sender: nil)
    }
    
    //MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        cell.memeImageView.image = memes[indexPath.row].memedImage
        return cell
    }
    
    //MARK: - UITableViewDelegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MemeDetailSegue", sender: memes[indexPath.row])
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check if the segue identifier is MemeDetailSegue
        if segue.identifier == "MemeDetailSegue"{
            // Get the new view controller using segue.destination.
            let destinationViewController = segue.destination as! MemeDetailViewController
            // Pass the selected object to the new view controller.
            let selectedMeme = sender as! Meme
            destinationViewController.meme = selectedMeme
        }
    }

}
