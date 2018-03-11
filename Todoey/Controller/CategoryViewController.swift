//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by 이종익 on 2018. 3. 10..
//  Copyright © 2018년 sow4063. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
                var textField = UITextField()
        
                let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
                let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
                    // what will happen once the user clicks the item Add Item button on our UIAlert
        
                    let newCategory = Category(context: self.context)
                    newCategory.name = textField.text!
        
                    self.categories.append(newCategory)
        
                    self.saveCategory()
        
                }
        
                alert.addTextField { (alertTextField) in
                    alertTextField.placeholder = "Add a new category"
                    textField = alertTextField
                }
        
                alert.addAction(action)
        
                present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategory() {
        do {
            try context.save()
        }
        catch {
            print("Errro saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
}
