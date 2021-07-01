//
//  RecipesRouter.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 30/06/2021.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    
    static func start() -> RecipesRouter
}

class RecipesRouter: AnyRouter {
    var entry: EntryPoint?
    
    
    static func start() -> RecipesRouter {
        let router = RecipesRouter()
        
        var view :AnyView =  SearchRecipesViewController()
        var presenter : AnyPresenter = RecipesPresenter()
        var interactor : AnyInteractor = RecipesInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}

