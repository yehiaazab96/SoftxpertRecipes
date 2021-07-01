//
//  Recipe.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 29/06/2021.
//

import Foundation

class RescipeResponse: Codable {
    var hits : Array<Hit>?
}
class Hit: Codable {
    var recipe : Recipe?
}
class Recipe: Codable {
    var uri : String?
    var label : String?
    var image : String?
    var source : String?
    var url : String?
    var yield : Int?
    var dietLabels: Array<String>?
    var healthLables : Array<String>?
    var cautions : Array<String>?
    var ingredientLines : Array<String>?
    var ingredients : Array<Ingredinet>?
    var calories : Double?
    var totalWeight : Double?
 
}

class Ingredinet : Codable {
    var text : String?
    var weight : Double?
    var foodCategory : String?
    var foodId : String?
    var image : String?
    
}
