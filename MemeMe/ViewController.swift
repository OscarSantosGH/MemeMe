//
//  ViewController.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/3/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        setMemeTextAttributes()
        overrideUserInterfaceStyle = .dark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    private func setMemeTextAttributes(){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth:  -3
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
    }
    
    func presentImagePicker(source: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = source
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePicker(source: .camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePicker(source: .photoLibrary)
    }
    
    @IBAction func share(_ sender: Any){
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityVC, animated: true)
        activityVC.completionWithItemsHandler = { [weak self] activityType, completed, returnedItems, error in
            guard let self = self else {return}
            if completed{
                self.saveMeme(memedImage: memedImage)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any){
        imagePickerView.image = UIImage()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    
    //MARK: UIImagePickerControllerDelegate functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let alertVC = UIAlertController(title: "Image size", message: "Did you want to crop the image or use the original size", preferredStyle: .alert)
        let originalAction = UIAlertAction(title: "Original", style: .cancel) { [weak self] (action) in
            guard let self = self else {return}
            if let image = info[.originalImage] as? UIImage {
                self.dismissImagePicker(picker: picker, withImage: image)
            }
        }
        let editAction = UIAlertAction(title: "Crop", style: .default) { [weak self] (action) in
            guard let self = self else {return}
            if let image = info[.editedImage] as? UIImage {
                self.dismissImagePicker(picker: picker, withImage: image)
            }
        }
        alertVC.addAction(originalAction)
        alertVC.addAction(editAction)
        
        picker.present(alertVC, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func dismissImagePicker(picker: UIImagePickerController, withImage image:UIImage){
        imagePickerView.image = image
        shareButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UITextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            if textField.tag == 0{
                textField.text = "TOP"
            }else{
                textField.text = "BOTTOM"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: NSNotifications functions
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    //MARK: generate Meme image
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        navBar.isHidden = true
        toolBar.isHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar
        navBar.isHidden = false
        toolBar.isHidden = false

        return memedImage
    }
    
    func saveMeme(memedImage:UIImage){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
    }
    
}
