//
//  RecipeDetails+UIExtension.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 03/07/2021.
//

import Foundation
import UIKit

extension RecipeDetailsViewContoller{
    func setupUI() {
        self.view.backgroundColor = .white
        
        let recipeImageFrame = CGRect(x: 0 , y: 0, width: (self.view.frame.width), height: 200)
        
        recipeImageView = UIImageView(frame: recipeImageFrame)
        recipeImageView?.sd_setImage(with: URL(string: recipe!.image!), completed: nil)
        recipeImageView?.contentMode = .scaleAspectFill
        
        self.view.addSubview(recipeImageView!)
        
        let recipesTitleLabelFrame = CGRect(x: 12, y:(recipeImageView?.image?.size.height)! , width: (self.view.frame.width - 24), height: 40)
        recipeTitleLabel = UILabel(frame: recipesTitleLabelFrame)
        recipeTitleLabel?.text = recipe?.label
        recipeTitleLabel?.textAlignment = .center
        recipeTitleLabel?.adjustsFontSizeToFitWidth = true
        recipeTitleLabel?.font = UIFont(name: "Didot", size: 22)
        self.view.addSubview(recipeTitleLabel!)
        
        let ingredintsTableViewFrame = CGRect(x: 0, y: ((recipeImageView?.image?.size.height)! + 52), width: (view.frame.width), height: 200)
        recipesIngredints = UITableView(frame: ingredintsTableViewFrame, style: .plain)
        recipesIngredints?.separatorStyle = .singleLine
        recipesIngredints!.delegate = self
        recipesIngredints!.dataSource = self
        
        recipesIngredints?.register( type(of: UITableViewCell(style: .subtitle, reuseIdentifier: "cell")).self, forCellReuseIdentifier: "cell")
        self.view.addSubview(recipesIngredints!)
        
        let recipesLinkButtonFrame = CGRect(x: 12, y:((recipeImageView?.image?.size.height)! + 280) , width: (self.view.frame.width - 24), height: 50)
        recipeLinkButoon = UIButton(frame: recipesLinkButtonFrame)
        recipeLinkButoon?.setTitle("Show Recipe Page", for: .normal)
        recipeLinkButoon?.backgroundColor = UIColor(red: 0, green: (100 / 365), blue: 0, alpha: 0.85)
        recipeLinkButoon?.addTarget(self, action: #selector(goToRecipePage), for: .touchUpInside)
        recipeLinkButoon?.layer.cornerRadius = 20
        self.view.addSubview(recipeLinkButoon!)
     
    }
}
