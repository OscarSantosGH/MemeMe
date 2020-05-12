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
        setMemeTextAttributes(withFontName: "impact")
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
        robotoFontBtn.addTarget(self, action: #selector(setPacificoFont), for: .touchUpInside)
        
        for fontBtn in availableFontsArray{
            fontBtn.setTitleColor(.black, for: .normal)
            fontBtn.showsTouchWhenHighlighted = true
            fontBtn.backgroundColor = .white
            fontBtn.layer.cornerRadius = 5

            containerStackView.addArrangedSubview(fontBtn)
        }
    }
    
    @objc func setImpactFont(){
        setMemeTextAttributes(withFontName: "impact")
    }
    
    @objc func setHelveticaFont(){
        setMemeTextAttributes(withFontName: "HelveticaNeue-CondensedBlack")
    }
    
    @objc func setPacificoFont(){
        setMemeTextAttributes(withFontName: "Roboto-Bold")
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
