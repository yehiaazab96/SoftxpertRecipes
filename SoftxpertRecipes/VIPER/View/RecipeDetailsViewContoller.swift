//
//  RecipeDetailsViewContoller.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 02/07/2021.
//

import UIKit
import SDWebImage
import SafariServices
class RecipeDetailsViewContoller: UIViewController {

    
    var recipeImageView : UIImageView?
    var recipeTitleLabel : UILabel?
    var recipesIngredints : UITableView?
    var recipeLinkButoon : UIButton?
    var recipe : Recipe?{
        didSet{
            ingredients = (recipe?.ingredients)!
            self.recipesIngredints?.reloadData()
        }
    }
    var ingredients : Array<Ingredinet> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func goToRecipePage(){
        if let url = recipe?.url {
               let config = SFSafariViewController.Configuration()
               config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: URL(string: url)!, configuration: config)
               present(vc, animated: true)
           }
    }
}


extension RecipeDetailsViewContoller : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.layer.cornerRadius = 15
        cell?.textLabel?.text = (ingredients[indexPath.row].text)
        cell?.textLabel?.adjustsFontSizeToFitWidth = true
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
