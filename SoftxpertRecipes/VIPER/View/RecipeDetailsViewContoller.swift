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
