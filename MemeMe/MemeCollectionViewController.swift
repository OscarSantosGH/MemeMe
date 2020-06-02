//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/28/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    // MARK: Outlets
    @IBOutlet weak var memeCollectionView: UICollectionView!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCollectionView()
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

// extension of MemeCollectionViewController that implement flowLayout delegate methods
extension MemeCollectionViewController: UICollectionViewDelegateFlowLayout{
    // set the minimum line spacing for the section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    // set the minimum spacing between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    // set the size of the items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // calculate the item size depending of the device orientation
        return calculateItemWidth(isPortrait: view.frame.size.height > view.frame.size.width)
        
    }
    // calculate the width of the collectionView minus the number of spaces between items in one row multiply by 3(the value in pixel of each space) divided by the number of items in each row
    func calculateItemWidth(isPortrait:Bool) -> CGSize{
        var dimension:CGFloat
        if isPortrait{
            dimension = (memeCollectionView.frame.size.width - (2 * 3.0)) / 3.0
        }else{
            dimension = (memeCollectionView.frame.size.width - (4 * 3.0)) / 5.0
        }
        return CGSize(width: dimension, height: dimension)
    }
}
