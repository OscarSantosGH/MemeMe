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
    let impactFontBtn = UIButton(type: .custom)
    let helveticaFontBtn = UIButton(type: .custom)
    let pacificoFontBtn = UIButton(type: .custom)
    var availableFontsArray: Array<UIButton>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        availableFontsArray = [impactFontBtn, helveticaFontBtn, pacificoFontBtn]
        containerStackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        containerStackView.alignment = .center
        containerStackView.axis = .horizontal
        containerStackView.distribution = .equalSpacing
        inputAccessoryView = containerStackView
        
        impactFontBtn.setTitle("IMPACT", for: .normal)
        impactFontBtn.addTarget(self, action: #selector(setImpactFont), for: .touchUpInside)
        
        helveticaFontBtn.setTitle("HELVETICA", for: .normal)
        helveticaFontBtn.addTarget(self, action: #selector(setHelveticaFont), for: .touchUpInside)
        
        pacificoFontBtn.setTitle("PACIFICO", for: .normal)
        pacificoFontBtn.addTarget(self, action: #selector(setPacificoFont), for: .touchUpInside)
        
        for fontBtn in availableFontsArray{
            fontBtn.setTitleColor(.black, for: .normal)
            fontBtn.showsTouchWhenHighlighted = true
            fontBtn.backgroundColor = .white
            fontBtn.layer.cornerRadius = 10
            
            containerStackView.addArrangedSubview(fontBtn)
        }
    }
    
    @objc func setImpactFont(){
        print("Impact")
    }
    
    @objc func setHelveticaFont(){
        print("Helvetica")
    }
    
    @objc func setPacificoFont(){
        print("Pacifico")
    }
    
}
