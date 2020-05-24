//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/24/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var memeTableView: UITableView!
    @IBOutlet weak var editMemeButton: UIBarButtonItem!
    
    // computed property with all the memes from the memes array in appDelegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // enable editMemeButton only if the memes array isn't empty.
        editMemeButton.isEnabled = !memes.isEmpty
    }
    
    
    //MARK: IBActions
    @IBAction func editMemes(_ sender: Any) {
        
    }
    
    @IBAction func createNewMeme(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateMemeSegue", sender: nil)
    }
    
    //MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableViewCell
        cell.set(with: memes[indexPath.row])
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
