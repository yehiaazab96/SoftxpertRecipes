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
    
    
    func interactorDidFetchHits(with result : Result<Array<Hit> , Error>)
    func interactorGotSearchParam(param : String)
}

class RecipesPresenter: AnyPresenter {
    func interactorGotSearchParam(param: String) {
        interactor?.getHits(param: param)
    }
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.getHits(param: "Chicken")
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchHits(with result: Result<Array<Hit>, Error>) {
        switch result {
        case .success(let hits):
            view?.update(with: hits)
        case .failure(let err):
            view?.update(with: err.localizedDescription)
        }
    }
    
    
    
}
