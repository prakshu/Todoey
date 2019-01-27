//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Prakshi Bector on 25/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {
    //So let's create a variable called categories that is going to be an array of category objects and willinitialize it as an empty array.
    var categoryArray = [Category]()
 
    //The next thing we need to do is we need to grab a reference to the context that we're going to be using in order to create read update and destroy our data.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        print(FileManager.default.urls(for: .documentDirectory , in: .userDomainMask))
       loadCategories()

        super.viewDidLoad()
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryArray[indexPath.row]
        cell.textLabel?.text = item.name

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
        destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        // this is the index path that is going to identify the current row that is selected.
    }
 

    // MARK: - Add new categories

     @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default)
            
        { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
           self.saveCategories()
            
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

    func saveCategories()
    {
        do
        {
            try context.save()
        
        }
        catch
        {
            print("error saving context \(error)")
            
        }
        self.tableView.reloadData()
        
    }
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest())
        
    {
        do
        {
            categoryArray =    try context.fetch(request)
        }
        catch
        {
            print("error fetching data from context \(error)")
        }
        self.tableView.reloadData()
        
        
    }

}
