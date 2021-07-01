//
//  URLs.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 30/06/2021.
//

import Foundation


class URls {
    static func getRecipesFiltered(param : String) -> String {
            return "https://api.edamam.com/api/recipes/v2?type=public&q=\(param)&app_id=99e5070c&app_key=e3ab3612227af60be13babecd136fb40"
    }
}
