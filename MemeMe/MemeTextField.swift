//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/11/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MemeTextField: UITextField {

    let containerStackView = UIStackView()
    let impactFontBtn = UIButton(type: .roundedRect)
    let helveticaFontBtn = UIButton(type: .roundedRect)
    let robotoFontBtn = UIButton(type: .roundedRect)
    var availableFontsArray: Array<UIButton>!
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        configure()
    }
    
    private func configure(){
        availableFontsArray = [impactFontBtn, helveticaFontBtn, robotoFontBtn]
        containerStackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        containerStackView.alignment = .center
        containerStackView.axis = .horizontal
        containerStackView.distribution = .fillEqually
        containerStackView.spacing = 10
        inputAccessoryView = containerStackView
        
        impactFontBtn.setTitle("IMPACT", for: .normal)
        impactFontBtn.addTarget(self, action: #selector(setImpactFont), for: .touchUpInside)
        
        helveticaFontBtn.setTitle("HELVETICA", for: .normal)
        helveticaFontBtn.addTarget(self, action: #selector(setHelveticaFont), for: .touchUpInside)
        
        robotoFontBtn.setTitle("ROBOTO", for: .normal)
        robotoFontBtn.addTarget(self, action: #selector(setRobotoFont), for: .touchUpInside)
        
        configureButtonsAppearances()
        
        for fontBtn in availableFontsArray{
            containerStackView.addArrangedSubview(fontBtn)
        }
        
        setImpactFont()
    }
    
    @objc func setImpactFont(){
        setMemeTextAttributes(withFontName: "impact")
        configureButtonsAppearances()
        impactFontBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    
    @objc func setHelveticaFont(){
        setMemeTextAttributes(withFontName: "HelveticaNeue-CondensedBlack")
        configureButtonsAppearances()
        helveticaFontBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    
    @objc func setRobotoFont(){
        setMemeTextAttributes(withFontName: "Roboto-Bold")
        configureButtonsAppearances()
        robotoFontBtn.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    }
    
    private func configureButtonsAppearances(){
        for fontBtn in availableFontsArray{
            fontBtn.setTitleColor(.black, for: .normal)
            fontBtn.backgroundColor = UIColor.init(white: 0.5, alpha: 0.8)
            fontBtn.layer.cornerRadius = 5
        }
    }
    
    private func setMemeTextAttributes(withFontName name:String){
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: name, size: 40)!,
            NSAttributedString.Key.strokeWidth:  -3
        ]
        defaultTextAttributes = memeTextAttributes
        textAlignment = .center
    }
    
}
