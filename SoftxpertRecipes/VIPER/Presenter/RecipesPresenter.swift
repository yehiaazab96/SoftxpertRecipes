//
//  RecipesPresenter.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 30/06/2021.
//

import Foundation


protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    
    func interactorDidFetchHits(with result : Result<RescipeResponse , Error>)
    func interactorGotSearchParam(param : String)
    func interactorDidFetchExtraHits(with result : Result<RescipeResponse , Error>)
    
}

class RecipesPresenter: AnyPresenter {
    
    
    
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            if let lastParam = UserDefaults.standard.string(forKey: "LastParam"){
                interactor?.getHits(param: lastParam , filterParam: nil)
            }
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchHits(with result: Result<RescipeResponse, Error>) {
        switch result {
        case .success(let response):
            view?.update(with: response.hits!)
            if let nextPage = response._links?.next?.href {
                view?.nextPage = nextPage
            }else{
                view?.nextPage = nil
            }
        case .failure(let err):
            view?.update(with: err.localizedDescription)
        }
    }
    
    func interactorDidFetchExtraHits(with result: Result<RescipeResponse, Error>) {
        switch result {
        case .success(let response):
            view?.addExtraHits(with: response.hits!)
            if let nextPage = response._links?.next?.href {
                view?.nextPage = nextPage
            }else{
                view?.nextPage = nil
            }
        case .failure(let err):
            view?.update(with: err.localizedDescription)
        }
    }
    
    func interactorGotSearchParam(param: String) {
        interactor?.getHits(param: param , filterParam: nil)
    }
    
    
    
}
