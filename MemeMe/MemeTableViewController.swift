//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/24/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: IBOutlet
    @IBOutlet weak var memeTableView: UITableView!
    
    // computed property with all the memes from the memes array in appDelegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the dataSource of the table to MemeTableViewController
        memeTableView.dataSource = self
        // Set the delegate of the table to MemeTableViewController
        memeTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
    
    func reloadTableView(){
        // reload the data of the tableView
        memeTableView.reloadData()
    }
    
    
    //MARK: IBAction
    @IBAction func createNewMeme(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateMemeSegue", sender: nil)
    }
    
    //MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableViewCell
        cell.set(with: memes[indexPath.row])
        return cell
    }
    
    //MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set the height for the cells
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // create a dictionary to store the selected meme and its index
        performSegue(withIdentifier: "MemeDetailSegue", sender: memes[indexPath.row])
    }
    
    // Method use to enable "Swipe to delete" on the tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the editingStyle is .delete the meme will be remove from the appDelegate memes array and the row in the table
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
