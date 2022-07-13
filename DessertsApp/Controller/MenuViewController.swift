//
//  MenuViewController.swift
//  Fetch Rewards App
//
//  Created by Trill Isaac on 7/10/22.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingredientsLabel2: UILabel!
    
    //Menu Details from table view
    var menuDetails : Meals?
    
    //Makes an Array of type MealDetails Object from struct
    var mealsInstructions : [MealsDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gets the menu ID and uses it for the URL to parse JSON Data
        let currentMenuID = menuDetails?.idMeal
        downloadJSONData(idString: (currentMenuID)!) {
        }
    }
    
    // Parse JSON Data to use for Meal Details
    func downloadJSONData(idString: String ,completed: @escaping () -> ()) {
        
        // let menuID = "\(String(describing: menuDetails?.idMeal))"
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idString)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    let jsondata = try JSONDecoder().decode(MealsInstructions.self, from: data!)
                    self.mealsInstructions = jsondata.meals
                    
                    DispatchQueue.main.async {
                        completed()
                        
                        //Menu image
                        self.imageView.downloaded(from: "\(jsondata.meals[0].strMealThumb)")
                        
                        //Menu Name
                        self.mealNameLabel.text = "\(jsondata.meals[0].strMeal)"
                        
                        //Menu Instructions
                        self.instructionsLabel.text = "Instructions:  \n\(jsondata.meals[0].strInstructions)"
                        
                        //Menu Ingredients
                        // Defaulted Null Values to Empty string so that they don't get displayed in Menu Detail View
                        self.ingredientsLabel.text =  "Ingredients:  \n\(jsondata.meals[0].strIngredient1 ?? "") \n\(jsondata.meals[0].strIngredient2 ?? "")  \n\(jsondata.meals[0].strIngredient3 ?? "") \n\(jsondata.meals[0].strIngredient4 ?? "")\n\(jsondata.meals[0].strIngredient5 ?? "")\n\(jsondata.meals[0].strIngredient6 ?? "")\n\(jsondata.meals[0].strIngredient7 ?? "")\n\(jsondata.meals[0].strIngredient8 ?? "") \n\(jsondata.meals[0].strIngredient9 ?? "")\n\(jsondata.meals[0].strIngredient10 ?? "")"
                        
                        self.ingredientsLabel2.text =  "\(jsondata.meals[0].strIngredient11 ?? "") \n\(jsondata.meals[0].strIngredient12 ?? "")  \n\(jsondata.meals[0].strIngredient13 ?? "") \n\(jsondata.meals[0].strIngredient14 ?? "")\n\(jsondata.meals[0].strIngredient15 ?? "")\n\(jsondata.meals[0].strIngredient16 ?? "")\n\(jsondata.meals[0].strIngredient17 ?? "")\n\(jsondata.meals[0].strIngredient18 ?? "") \n\(jsondata.meals[0].strIngredient19 ?? "")\n\(jsondata.meals[0].strIngredient20 ?? "")"
                    }
                    
                }catch {
                    print("There was an error with decoding JSON Data")
                    print(error)
                }
            }
        } .resume()
    }
}

// extention to use images for food in the Menu Details Screen
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


