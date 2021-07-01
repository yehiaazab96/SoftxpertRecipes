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
    
    func getHits(param : String)
}

class RecipesInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getHits(param : String) {

        AF.request(URls.getRecipesFiltered(param: param))
                    .validate()
                    .responseDecodable(of: RescipeResponse.self){ (response) in
                    switch response.result {
        
                    case .success(_):
                        guard let recipesData = response.value else {return}
                        self.presenter?.interactorDidFetchHits(with: .success(recipesData.hits!))
        
                    case .failure(_):
                        self.presenter?.interactorDidFetchHits(with: .failure(response.error!))
                    }
            }

    }
    
    
}
