//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by 이종익 on 2018. 3. 10..
//  Copyright © 2018년 sow4063. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category is added yet"
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
                var textField = UITextField()
        
                let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
                let action = UIAlertAction(title: "Add", style: .default) { (action) in
                    // what will happen once the user clicks the item Add Item button on our UIAlert
        
                    let newCategory = Category()
                    newCategory.name = textField.text!
                
                    self.save(category: newCategory)
        
                }
        
                alert.addTextField { (alertTextField) in
                    alertTextField.placeholder = "Add a new category"
                    textField = alertTextField
                }
        
                alert.addAction(action)
        
                present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Errro saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
       

        tableView.reloadData()
    }
    
    
    
}
