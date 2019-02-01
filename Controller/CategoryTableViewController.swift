//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Prakshi Bector on 25/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryTableViewController: UITableViewController {
    
    //So let's create a variable called categories that is going to be an array of category objects and willinitialize it as an empty array.
    //So instead of making it a forced unwrapped I'm going to add a question mark to this data type and make categories an optional.
    var categoryArray : Results<Category>?
 let realm = try! Realm()
    //The next thing we need to do is we need to grab a reference to the context that we're going to be using in order to create read update and destroy our data.


    override func viewDidLoad() {
    loadCategories()

        super.viewDidLoad()
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //So now instead of saying categories.count I'm going to say if category's is not nil then return categories.count.But if it is new then just return one.
        return categoryArray?.count ?? 1
        //So this is a new bit of syntax and this in swift is called the nil coalescing operator.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
           cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added yet"

        return cell
    }

    // MARK: - Table view delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
   
       // saveItems()
       
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
       if let indexPath = tableView.indexPathForSelectedRow
       {
        destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        // this is the index path that is going to identify the current row that is selected.
    }
 

    // MARK: - Add new categories

     @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default)
            
        { 
            (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
           self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Add a new Category"

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        print("vfggfgfs")
        
        
     }
    // MARK: - data manipulation methods

    func save(category: Category)
    {
        do
        {
            try realm.write {
                realm.add(category)
            }
        
        }
        catch
        {
            print("error saving context \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    func loadCategories()
    {

    categoryArray = realm.objects(Category.self)
        tableView.reloadData()

}
}
