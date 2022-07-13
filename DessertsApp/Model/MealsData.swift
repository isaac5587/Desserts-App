//
//  MealsData.swift
//  Fetch Rewards App
//
//  Created by Trill Isaac on 7/10/22.
//

import Foundation
import UIKit

//Structs for the JSON Data used for the table view

struct MealsData : Codable {
    var meals : [Meals]
}

struct Meals : Codable {
    var strMeal : String
    var strMealThumb : String
    var idMeal : String
}

//Structs for the JSON Data used for the Menu details screen
struct MealsInstructions : Codable {
    var meals : [MealsDetails]
}

struct MealsDetails : Codable {
    var strMeal : String
    var strMealThumb : String
    var idMeal : String
    var strInstructions: String
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
}


