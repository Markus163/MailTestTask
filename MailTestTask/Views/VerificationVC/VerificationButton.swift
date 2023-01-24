//
//  VerificationButton.swift
//  MailTestTask
//
//  Created by Марк Михайлов on 19.01.2023.
//

import Foundation
import UIKit

class VerificationButton: UIButton {
    
    public var isValid = false {
        didSet {
            if self.isValid {
                setValidSettings()
            } else {
               setNotValidSettings()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9333333333, blue: 0.862745098, alpha: 1)
        setTitle("Verrification button", for: .normal)
        let color = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "AvenirBook", size: 17)
        isEnabled = false
        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setNotValidSettings() {
        isEnabled = false
        alpha = 0.5
    }
    
    private func setValidSettings() {
        isEnabled = true
        alpha = 1.0
    }
    
    public func setDeafaultsettings() {
        configure()
    }
}
