//
//  RecipeCell.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 29/06/2021.
//

import UIKit

class RecipeCell: UITableViewCell {

    var parentBackgroundView: UIView?
    var recipeImageView: UIImageView?
    var recipeNameLabel: UILabel?
    var recipeSourceLabel: UILabel?
//    var recipeTagsCollectionView: UICollectionView?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        parentBackgroundView = UIView()
        parentBackgroundView?.backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        
        recipeImageView = UIImageView()
        
        recipeNameLabel = UILabel()
        recipeNameLabel?.textAlignment = .center
        recipeNameLabel?.font = UIFont(name: "Didot", size: 17)
        recipeNameLabel?.lineBreakMode = .byWordWrapping
        recipeNameLabel?.numberOfLines = 0
        
        recipeSourceLabel = UILabel()
        recipeSourceLabel?.textAlignment = .center
        recipeSourceLabel?.font = UIFont(name: "Didot", size: 12)
        recipeSourceLabel?.textColor = UIColor(white: 0.3, alpha: 1)
        
//        recipeTagsCollectionView = UICollectionView()
        
        parentBackgroundView?.addSubview(recipeImageView!)
        parentBackgroundView?.addSubview(recipeNameLabel!)
        parentBackgroundView?.addSubview(recipeSourceLabel!)
//        parentBackgroundView?.addSubview(recipeTagsCollectionView!)
        
        self.contentView.addSubview(parentBackgroundView!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        parentBackgroundView?.frame = CGRect(x: 12, y: 12, width: (self.contentView.frame.width - 24 ), height: 150)
        parentBackgroundView!.layer.cornerRadius = 20
        
        recipeImageView?.frame = CGRect(x: 12, y: 12, width: 126, height: 126)
        recipeImageView!.layer.cornerRadius = 20
        recipeImageView?.clipsToBounds = true
        recipeImageView!.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        recipeImageView!.layer.borderWidth = 2
        
        recipeNameLabel?.frame = CGRect(x: 150, y: 18, width: ((parentBackgroundView?.frame.width)! - 162) , height: 30)
            
        recipeSourceLabel?.frame = CGRect(x: 150, y: 46, width: ((parentBackgroundView?.frame.width)! - 162) , height: 20)

    }
    
}
