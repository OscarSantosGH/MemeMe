//
//  FontsAccessoryView.swift
//  MemeMe
//
//  Created by Oscar Santos on 5/11/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class FontsAccessoryView: UIStackView {

    let impactFontBtn = UIButton(type: .roundedRect)
    let helveticaFontBtn = UIButton(type: .roundedRect)
    let pacificoFontBtn = UIButton(type: .roundedRect)
    var availableFontsArray: Array<UIButton>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        availableFontsArray = [impactFontBtn, helveticaFontBtn, pacificoFontBtn]
        frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        alignment = .center
        axis = .horizontal
        distribution = .fillEqually
        insetsLayoutMarginsFromSafeArea = true
        spacing = 5
        
        impactFontBtn.setTitle("IMPACT", for: .normal)
        impactFontBtn.addTarget(self, action: #selector(setImpactFont), for: .touchUpInside)
        
        helveticaFontBtn.setTitle("HELVETICA", for: .normal)
        helveticaFontBtn.addTarget(self, action: #selector(setHelveticaFont), for: .touchUpInside)
        
        pacificoFontBtn.setTitle("PACIFICO", for: .normal)
        pacificoFontBtn.addTarget(self, action: #selector(setPacificoFont), for: .touchUpInside)
        
        for fontBtn in availableFontsArray{
            fontBtn.setTitleColor(.black, for: .normal)
            fontBtn.showsTouchWhenHighlighted = true
            fontBtn.backgroundColor = UIColor(white: 1, alpha: 0.8)
            fontBtn.layer.cornerRadius = 5
            addArrangedSubview(fontBtn)
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
