//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Amanda Lui on 7/4/19.
//  Copyright © 2019 Amanda Lui. All rights reserved.
//

import os.log
import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample daya.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // Load the sample data.
            loadSampleMeals()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
            case "AddItem":
                os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                guard let mealDetailViewController = segue.destination as? MealViewController
                    else {
                        fatalError("Unexpected destination: \(segue.destination)")
                }
            
            guard let selectedMealCell = sender as? MealTableViewCell
                else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell)
                else {
                    fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    
    // MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals.
            saveMeals()
        }
    }

    // MARK: Private Methods
    
    private func loadSampleMeals() {
        
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        let photo4 = UIImage(named: "meal4")
        let photo5 = UIImage(named: "meal5")
        let photo6 = UIImage(named: "meal6")
        let photo7 = UIImage(named: "meal7")
        let photo8 = UIImage(named: "meal8")
        let photo9 = UIImage(named: "meal9")
        let photo10 = UIImage(named: "meal10")
        let photo11 = UIImage(named: "meal11")
        
        guard let meal1 = Meal(name: "Avocado Sandwich", photo: photo1, rating: 4)
            else {
                fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Grilled Sandwich", photo: photo2, rating: 5)
            else {
                fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "French Toast", photo: photo3, rating: 3)
            else {
                fatalError("Unable to instantiate meal3")
        }
        
        guard let meal4 = Meal(name: "Baked Salmon", photo: photo4, rating: 5)
            else {
                fatalError("Unable to instantiate meal4")
        }
        
        guard let meal5 = Meal(name: "Pesto Fettuccine", photo: photo5, rating: 4)
            else {
                fatalError("Unable to instantiate meal5")
        }
        
        guard let meal6 = Meal(name: "California Pizza", photo: photo6, rating: 4)
            else {
                fatalError("Unable to instantiate meal6")
        }
        
        guard let meal7 = Meal(name: "Kobe Beef Burger", photo: photo7, rating: 5)
            else {
                fatalError("Unable to instantiate meal7")
        }
        
        guard let meal8 = Meal(name: "Chashu Ramen", photo: photo8, rating: 3)
            else {
                fatalError("Unable to instantiate meal8")
        }
        
        guard let meal9 = Meal(name: "Curry Chicken", photo: photo9, rating: 4)
            else {
                fatalError("Unable to instantiate meal9")
        }
            
        guard let meal10 = Meal(name: "Butternut Squash Soup", photo: photo10, rating: 4)
            else {
            fatalError("Unable to instantiate meal10")
            }
        
        guard let meal11 = Meal(name: "Fresh Fruit Parfait", photo: photo11, rating: 5)
            else {
                fatalError("Unable to instantiate meal11")
        }
        
        meals += [meal1, meal2, meal3, meal4, meal5, meal6, meal7, meal8, meal9, meal10, meal11]
    }
    
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfulle saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    
}
