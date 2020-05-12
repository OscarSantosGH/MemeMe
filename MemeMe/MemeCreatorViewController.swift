//
//  ViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/3/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeCreatorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    // MemeTextField is a custom UITextField that has an inputAccessoryView with 3 buttons that change the font of the textField
    @IBOutlet weak var topTextField: MemeTextField!
    @IBOutlet weak var bottomTextField: MemeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the delegate of the textField to MemeCreatorViewController
        topTextField.delegate = self
        bottomTextField.delegate = self
        // Create a UITapGestureRecognizer an add it to imagePickerView to be able to call imageViewTapped function when the user touch it
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        memeImageView.addGestureRecognizer(tapGesture)
        // Force the view to always use the darkMode. That's a design choice.
        overrideUserInterfaceStyle = .dark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Disable the camera button if the device doesn't had a camera (like the simulator).
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // Disable the share button because at this point the user doesn't have a meme to share.
        shareButton.isEnabled = false
        // subscribeToKeyboardNotifications function set a listener to the view that activate when the keyboard appear and disappear.
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // unsubscribeFromKeyboardNotifications function remove the listener from the view.
        unsubscribeFromKeyboardNotifications()
    }
    
    // This objc function is called when the user tap on imagePickerView.
    @objc func imageViewTapped(){
        // Present the image picker controller with photoLibrary sourceType.
        presentImagePicker(source: .photoLibrary)
    }
    
    // Present the UIImagePickerController with the sourceType parameter to be able to choose the source from the call side.
    func presentImagePicker(source: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = source
        // allowsEditing allows the user to crop the image when selected.
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: IBActions
    // This function is called when the user tap the Camera button.
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        // Present the image picker controller with camera sourceType.
        presentImagePicker(source: .camera)
    }
    // This function is called when the user tap the Album button.
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        // Present the image picker controller with photoLibrary sourceType.
        presentImagePicker(source: .photoLibrary)
    }
    // This function is called when the user tap the Share button.
    @IBAction func share(_ sender: Any){
        // Get an UIImage with the top an bottom labels
        let memedImage = generateMemedImage()
        // Create an UIActivityViewController with the memedImage as activityItem.
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityVC, animated: true)
        // The completion handler to execute after the activity view controller is dismissed.
        // Used [weak self] capture list to prevent retain cycles.
        activityVC.completionWithItemsHandler = { [weak self] activityType, completed, returnedItems, error in
            // This is a handy trick to save unwraps self
            guard let self = self else {return}
            // if the UIActivityViewController is dismissed without problems _saveMeme_ function will be called
            if completed{
                self.saveMeme(memedImage: memedImage)
            }
        }
    }
    // This function is called when the user tap the Cancel button.
    @IBAction func cancel(_ sender: Any){
        // The view will reset to his initial state.
        memeImageView.image = UIImage(named: "imgPlaceholder")
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate functions
    // This function will be called when the user finish Picking the image.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Create a UIAlertController with 2 action to give the user the ability to choose between the original image size or the crop version
        let alertVC = UIAlertController(title: "Image size", message: "Did you want to crop the image or use the original size", preferredStyle: .alert)
        // Create a UIAlertAction to select the original image
        let originalAction = UIAlertAction(title: "Original", style: .cancel) { [weak self] (action) in
            guard let self = self else {return}
            // Take the original image an casted as UIImage
            if let image = info[.originalImage] as? UIImage {
                self.dismissImagePicker(picker: picker, withImage: image)
            }
        }
        // Create a UIAlertAction to select the cropped image
        let cropAction = UIAlertAction(title: "Crop", style: .default) { [weak self] (action) in
            guard let self = self else {return}
            // Take the cropped image an casted as UIImage
            if let image = info[.editedImage] as? UIImage {
                self.dismissImagePicker(picker: picker, withImage: image)
            }
        }
        // Add the action button to the alert view controller
        alertVC.addAction(originalAction)
        alertVC.addAction(cropAction)
        
        picker.present(alertVC, animated: true)
    }
    // Dismiss the imagePickerController when the user tap the Cancel button
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    // Custom dismissImagePicker function that takes the UIImagePickerController to dismiss it and a UIImage to presented
    func dismissImagePicker(picker: UIImagePickerController, withImage image:UIImage){
        memeImageView.image = image
        // Enable the share button
        shareButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate functions
    // Erase the content of the textField when the user tap begin editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    // Reset the value to the original text if the user leave the textField empty
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            if textField.tag == 0{
                textField.text = "TOP"
            }else{
                textField.text = "BOTTOM"
            }
        }
    }
    // Dismiss the keyboard when the user tap the Return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: NSNotifications functions
    // Set a listener to the view that activate when the keyboard appear and disappear.
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // Remove the listener from the view.
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        // Elevate the view up only if the bottomTextField begin editing
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        // Reset the y position of the view
        view.frame.origin.y = 0
    }
    // Get the size of the keyboard and return it to know how much the view needs to move in the y axes.
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    //MARK: generate Meme image
    func generateMemedImage() -> UIImage {

        // Hide toolbar and navbar
        navBar.isHidden = true
        toolBar.isHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show toolbar and navbar
        navBar.isHidden = false
        toolBar.isHidden = false

        return memedImage
    }
    
    //MARK: Save Meme to PhotoAlbum
    func saveMeme(memedImage:UIImage){
        // Create a Meme object
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: memedImage)
        // Save the memedImage of the Meme object to PhotoAlbum
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
    }
    
}
