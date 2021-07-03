//
//  SearchRecipesViewController.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 29/06/2021.
//

import UIKit
import SDWebImage
import iOSDropDown

protocol AnyView {
    var presenter : AnyPresenter? {get set}
    var nextPage : String? {get set}
    func update(with hits : [Hit])
    func update(with error : String)
    func addExtraHits(with hits : [Hit])
    
}

class SearchRecipesViewController: UIViewController , AnyView {
    
    var presenter: AnyPresenter?
    var nextPage : String?
    var recipesTableView: UITableView?
    var recipesSearchBar : UISearchBar?
    var recipesFilterView : UIStackView?
    var allButton : UIButton?
    var lowSugarButton : UIButton?
    var veganButton : UIButton?
    var ketoButton : UIButton?
    var hits : Array<Hit> = []
    var  dropDown : DropDown?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showSpinner()
        if (UserDefaults.standard.string(forKey: "LastParam") == nil){
            stopSpinner()
        }
    }
    
    func update(with hits: [Hit]) {
        DispatchQueue.main.async {
            self.hits = hits
            self.recipesTableView?.reloadData()
            self.stopSpinner()
            if hits.count == 0 {
                self.showAlert(title: "No Result", message: "There are no recipes matching the search keyword")
            }
        }
    }
    
    func update(with error: String) {
        stopSpinner()
        self.showAlert(title: "Something Went Wrong", message: error)
    }
    
    func addExtraHits(with hits: [Hit]) {
        DispatchQueue.main.async {
            hits.forEach { hit in
                self.hits.append(hit)
            }
            self.recipesTableView?.reloadData()
            self.stopSpinner()
        }
    }
    
    @objc func filterButtonPressed(sender : UIButton){
        print(sender.currentTitle!)
        switch sender.currentTitle! {
        case "All":
            filterBySelectedFilter(filter: nil)
        case "Keto":
            filterBySelectedFilter(filter: "keto-friendly")
        case "Low Sugar":
            filterBySelectedFilter(filter: "low-sugar")
        case "Vegan":
            filterBySelectedFilter(filter: "vegan")
        default:
            break
        }
    }
    
    func filterBySelectedFilter(filter : String?){
        if let lastParam = UserDefaults.standard.string(forKey: "LastParam"){
            print(lastParam)
            self.presenter?.interactor?.getHits(param: lastParam, filterParam: filter)
            showSpinner()
        }
    }
}


extension SearchRecipesViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.hits.count - 1{
            print("end")
            if let nextRecipesPage = nextPage {
                self.presenter?.interactor?.getExtraHits(pageUrl: nextRecipesPage)
                showSpinner()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        cell.recipeImageView!.sd_setImage(with: URL(string: (hits[indexPath.row].recipe?.image)!) , completed: nil)
        cell.recipeNameLabel!.text = hits[indexPath.row].recipe?.label
        cell.recipeSourceLabel!.text = hits[indexPath.row].recipe?.source
        cell.recipesTags = hits[indexPath.row].recipe?.healthLabels ?? []
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailsVC = RecipeDetailsViewContoller()
        recipeDetailsVC.recipe = hits[indexPath.row].recipe
        self.show(recipeDetailsVC, sender: self)
    }
}

extension SearchRecipesViewController : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dropDown?.isHidden = false
        dropDown?.text = ""
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dropDown?.isHidden = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dropDown?.isHidden = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            let searchParam = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
            self.presenter?.interactorGotSearchParam(param: searchParam)
            recipesSearchBar?.resignFirstResponder()
            UserDefaults.standard.setValue(searchParam, forKey: "LastParam")
            if var lastSearchArray = UserDefaults.standard.stringArray(forKey: "LastSearchArray"){
                if !lastSearchArray.contains(searchParam){
                    if lastSearchArray.count > 10 {
                        lastSearchArray.remove(at: 0)
                        lastSearchArray.append(searchParam)
                        UserDefaults.standard.setValue(lastSearchArray, forKey: "LastSearchArray")
                        self.dropDown?.optionArray = lastSearchArray
                    }else{
                        lastSearchArray.append(searchParam)
                        UserDefaults.standard.setValue(lastSearchArray, forKey: "LastSearchArray")
                        self.dropDown?.optionArray = lastSearchArray
                    }
                }
            }else{
                UserDefaults.standard.setValue([searchParam], forKey: "LastSearchArray")
            }
            self.showSpinner()
        }
    }
}
