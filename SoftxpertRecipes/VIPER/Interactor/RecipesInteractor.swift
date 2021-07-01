//
//  RecipesInteractor.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 30/06/2021.
//

import Foundation
import Alamofire


protocol AnyInteractor  {
    var presenter : AnyPresenter? {get set}
    
    func getHits(param : String , filterParam : String?)
    func getExtraHits(pageUrl : String)
}

class RecipesInteractor: AnyInteractor {
    
    
   
    var presenter: AnyPresenter?
    
    func getExtraHits(pageUrl: String) {
        AF.request(pageUrl)
                    .validate()
                    .responseDecodable(of: RescipeResponse.self){ (response) in
                    switch response.result {
        
                    case .success(_):
                        guard let recipesData = response.value else {return}
                        self.presenter?.interactorDidFetchExtraHits(with: .success(recipesData))
        
                    case .failure(_):
                        self.presenter?.interactorDidFetchExtraHits(with: .failure(response.error!))
                    }
            }

    }
    
    func getHits(param : String , filterParam : String?) {

        AF.request(URls.getRecipesFiltered(param: param , filter: filterParam))
                    .validate()
                    .responseDecodable(of: RescipeResponse.self){ (response) in
                    switch response.result {
        
                    case .success(_):
                        guard let recipesData = response.value else {return}
                        self.presenter?.interactorDidFetchHits(with: .success(recipesData))
        
                    case .failure(_):
                        self.presenter?.interactorDidFetchHits(with: .failure(response.error!))
                    }
            }

    }
    
    
}
