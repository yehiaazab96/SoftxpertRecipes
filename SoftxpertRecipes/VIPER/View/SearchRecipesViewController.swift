//
//  SearchRecipesViewController.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 29/06/2021.
//

import UIKit
import SDWebImage

protocol AnyView {
    var presenter : AnyPresenter? {get set}
    func update(with hits : [Hit])
    func update(with error : String)


}



class SearchRecipesViewController: UIViewController , AnyView {
   
    var presenter: AnyPresenter?
    var recipesTableView: UITableView?
    var recipesSearchBar : UISearchBar?
    var recipesFilterView : UIStackView?
    var hits : Array<Hit> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showSpinner()
    }
    
    func update(with hits: [Hit]) {
        DispatchQueue.main.async {
            print(hits)
            self.hits = hits
            self.recipesTableView?.reloadData()
            self.stopSpinner()
        }
    }
    
    func update(with error: String) {
        print(error)
        stopSpinner()
    }
    
}


extension SearchRecipesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        cell.recipeImageView!.sd_setImage(with: URL(string: (hits[indexPath.row].recipe?.image)!) , completed: nil)
        cell.recipeNameLabel!.text = hits[indexPath.row].recipe?.label
        cell.recipeSourceLabel!.text = hits[indexPath.row].recipe?.source
        print("befor return")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
}


extension SearchRecipesViewController {
    func setupUI() {
        self.view.backgroundColor = .white

        let searchBarFrame = CGRect(x: 12 , y: 40, width: (view.frame.width - 24), height: 50)
        recipesSearchBar = UISearchBar(frame: searchBarFrame)
        recipesSearchBar?.delegate = self
        self.view.addSubview(recipesSearchBar!)
     
        
        let recipesFilterViewFrame = CGRect(x: 0, y: 102, width: (view.frame.width), height: 60)
        recipesFilterView = UIStackView(frame: recipesFilterViewFrame)
        self.view.addSubview(recipesFilterView!)
     
        
        let recipesTableViewFrame = CGRect(x: 0, y: 174, width: (view.frame.width), height: (view.frame.height - 186))
        recipesTableView = UITableView(frame: recipesTableViewFrame, style: .plain)
        recipesTableView?.separatorStyle = .none
        recipesTableView!.delegate = self
        recipesTableView!.dataSource = self
        recipesTableView?.register( RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        self.view.addSubview(recipesTableView!)
    }
}

extension SearchRecipesViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            let searchParam = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
            self.presenter?.interactorGotSearchParam(param: searchParam)
            recipesSearchBar?.resignFirstResponder()
            self.showSpinner()
        }
    }
}
