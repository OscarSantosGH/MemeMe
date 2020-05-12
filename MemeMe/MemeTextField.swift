//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/11/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
// MemeTextField is a custom UITextField that has an inputAccessoryView with 3 buttons that change the font of the textField
class MemeTextField: UITextField {
    //MARK: Properties
    // Create a StackView that will contain the 3 buttons.
    let containerStackView = UIStackView()
    // Create the UIButtons with roundedRect type to change the font of this textField
    let impactFontBtn = UIButton(type: .roundedRect)
    let helveticaFontBtn = UIButton(type: .roundedRect)
    let robotoFontBtn = UIButton(type: .roundedRect)
    // Create an Array to put all the fontBtns for handle commons properties and avoid duplicate code
    var availableFontsArray: Array<UIButton>!
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        configure()
    }
    // Configure the view when is initialized
    private func configure(){
        // Populate the array with the buttons
        availableFontsArray = [impactFontBtn, helveticaFontBtn, robotoFontBtn]
        // Configure the containerStackView
        containerStackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        containerStackView.alignment = .center
        containerStackView.axis = .horizontal
        containerStackView.distribution = .fillEqually
        containerStackView.spacing = 10
        // Set the containerStackView as the inputAccessoryView of the UITextField
        inputAccessoryView = containerStackView
        
        // Configure the title and the target of the buttons
        impactFontBtn.setTitle("IMPACT", for: .normal)
        impactFontBtn.addTarget(self, action: #selector(setImpactFont), for: .touchUpInside)
        
        helveticaFontBtn.setTitle("HELVETICA", for: .normal)
        helveticaFontBtn.addTarget(self, action: #selector(setHelveticaFont), for: .touchUpInside)
        
        robotoFontBtn.setTitle("ROBOTO", for: .normal)
        robotoFontBtn.addTarget(self, action: #selector(setRobotoFont), for: .touchUpInside)
        // configureButtonsAppearances function as the name implied configure the appearance of the buttons
        configureButtonsAppearances()
        
        // Add the buttons to the containerStackView
        for fontBtn in availableFontsArray{
            containerStackView.addArrangedSubview(fontBtn)
        }
        // Set Impact font as the default appearance
        setImpactFont()
    }
    // setImpactFont is called when the user touch the IMPACT button
    @objc func setImpactFont(){
        // Set the text attributes with the impact font
        setMemeTextAttributes(withFontName: "impact")
        // Reset all the button appearances
        configureButtonsAppearances()
        // Chance the backgroundColor of this button to indicated this is the one selected
        impactFontBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    // setHelveticaFont is called when the user touch the HELVETICA button
    @objc func setHelveticaFont(){
        setMemeTextAttributes(withFontName: "HelveticaNeue-CondensedBlack")
        configureButtonsAppearances()
        helveticaFontBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    // setRobotoFont is called when the user touch the ROBOTO button
    @objc func setRobotoFont(){
        setMemeTextAttributes(withFontName: "Roboto-Bold")
        configureButtonsAppearances()
        robotoFontBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    // Configure the appearance of the buttons
    private func configureButtonsAppearances(){
        for fontBtn in availableFontsArray{
            fontBtn.setTitleColor(.black, for: .normal)
            fontBtn.backgroundColor = UIColor.init(white: 0.5, alpha: 0.8)
            fontBtn.layer.cornerRadius = 5
        }
    }
    // Set the textAttributes of the UITextField and take a String as a parameter witch needs to be the name of the font
    private func setMemeTextAttributes(withFontName name:String){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: name, size: 40)!,
            .strokeWidth: -3
        ]
        defaultTextAttributes = memeTextAttributes
        textAlignment = .center
    }
    
}
