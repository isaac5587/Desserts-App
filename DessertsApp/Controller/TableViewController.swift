//
//  ViewController.swift
//  Fetch Rewards App
//
//  Created by Trill Isaac on 7/10/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Makes an Array of type Meals Object from struct
    var mealsData : [Meals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSONData {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Using the segue to transition to the Menu Detail Screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailViewSegue", sender: self)
    }
    
    
    //Switching to Menu view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MenuViewController {
            destination.menuDetails = mealsData[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    //Parsing the JSON Data
    func downloadJSONData(completed: @escaping () -> ()) {
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    let jsondata = try JSONDecoder().decode(MealsData.self, from: data!)
                    self.mealsData = jsondata.meals
                                                            
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                }catch {
                    print("There was an error with decoding JSON Data")
                    print(error)
                }
            }
        } .resume()
    }
    
    //Limits the table view cell count to the number of items in mealsData
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsData.count
    }
    
    //Puts all the meal names into table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = mealsData[indexPath.row].strMeal.capitalized
        return cell
    }
}

