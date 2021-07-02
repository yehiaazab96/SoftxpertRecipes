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
    
    func addExtraHits(with hits: [Hit]) {
        DispatchQueue.main.async {
            print(hits)
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
    }
}

extension SearchRecipesViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            let searchParam = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
            self.presenter?.interactorGotSearchParam(param: searchParam)
            recipesSearchBar?.resignFirstResponder()
            UserDefaults.standard.setValue(searchParam, forKey: "LastParam")
            self.showSpinner()
        }
    }
}
