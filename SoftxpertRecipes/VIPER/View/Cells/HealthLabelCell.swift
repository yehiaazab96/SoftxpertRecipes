//
//  HealthLabel.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 01/07/2021.
//

import UIKit

class HealthLabel: UICollectionViewCell {
    
    
    var healthLabel : UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: (100 / 365), blue: 0, alpha: 0.4)
        self.layer.cornerRadius = self.frame.height / 2
        healthLabel = UILabel()
        healthLabel?.font = UIFont.systemFont(ofSize: 10)
        healthLabel?.adjustsFontSizeToFitWidth = true
        healthLabel?.textColor = .white
        healthLabel?.textAlignment = .center
        self.addSubview(healthLabel!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        healthLabel?.frame = CGRect(x: 3, y: 3, width: self.frame.width - 6, height: self.frame.height - 6)
    }
}
