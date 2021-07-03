//
//  SearchRecipes+UIExtention.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 03/07/2021.
//

import Foundation
import UIKit
import iOSDropDown

extension SearchRecipesViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        
        let searchBarFrame = CGRect(x: 12 , y: 40, width: (view.frame.width - 24), height: 50)
        recipesSearchBar = UISearchBar(frame: searchBarFrame)
        recipesSearchBar?.delegate = self
        recipesSearchBar?.keyboardType = .alphabet
        self.view.addSubview(recipesSearchBar!)
        
        
        let recipesFilterViewFrame = CGRect(x: 12, y: 102, width: (view.frame.width - 24), height: 60)
        recipesFilterView = UIStackView(frame: recipesFilterViewFrame)
        recipesFilterView?.axis = .horizontal
        recipesFilterView?.alignment = .center
        recipesFilterView?.distribution = .fillEqually
        recipesFilterView?.spacing = 20
        self.view.addSubview(recipesFilterView!)
        
        allButton = UIButton()
        allButton?.setTitle("All", for: .normal)
        allButton?.backgroundColor = UIColor(red: 0, green: (100 / 365), blue: 0, alpha: 0.85)
        allButton?.layer.cornerRadius = 5
        allButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        allButton?.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        allButton?.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        
        
        lowSugarButton = UIButton()
        lowSugarButton?.setTitle("Low Sugar", for: .normal)
        lowSugarButton?.backgroundColor = UIColor(red: 0, green: (100 / 365), blue: 0, alpha: 0.85)
        lowSugarButton?.layer.cornerRadius = 5
        lowSugarButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        lowSugarButton?.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        lowSugarButton?.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        
        
        ketoButton = UIButton()
        ketoButton?.setTitle("Keto", for: .normal)
        ketoButton?.backgroundColor = UIColor(red: 0, green: (100 / 365), blue: 0, alpha: 0.85)
        ketoButton?.layer.cornerRadius = 5
        ketoButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        ketoButton?.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        ketoButton?.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        
        
        veganButton = UIButton()
        veganButton?.setTitle("Vegan", for: .normal)
        veganButton?.backgroundColor = UIColor(red: 0, green: (100 / 365), blue: 0, alpha: 0.85)
        veganButton?.layer.cornerRadius = 5
        veganButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        veganButton?.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        veganButton?.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        
        
        recipesFilterView?.addArrangedSubview(allButton!)
        recipesFilterView?.addArrangedSubview(lowSugarButton!)
        recipesFilterView?.addArrangedSubview(ketoButton!)
        recipesFilterView?.addArrangedSubview(veganButton!)
        
        
        let recipesTableViewFrame = CGRect(x: 0, y: 174, width: (view.frame.width), height: (view.frame.height - 186))
        recipesTableView = UITableView(frame: recipesTableViewFrame, style: .plain)
        recipesTableView?.separatorStyle = .none
        recipesTableView!.delegate = self
        recipesTableView!.dataSource = self
        recipesTableView?.register( RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        self.view.addSubview(recipesTableView!)
        
        dropDown = DropDown(frame: CGRect(x: 36 , y: 40, width: (view.frame.width - 62), height: 50))
        dropDown!.optionArray = UserDefaults.standard.stringArray(forKey: "LastSearchArray") ?? []
        dropDown!.didSelect{(selectedText , index ,id) in
            self.dropDown?.isHidden = true
            self.recipesSearchBar?.text = selectedText
            
        }
        dropDown?.text = ""
        self.view.addSubview(dropDown!)
        dropDown?.isHidden = true
        
    }
}
