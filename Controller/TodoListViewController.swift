//
//  ViewController.swift
//  Todoey
//
//  Created by Prakshi Bector on 7/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController
{
//    var itemArray = ["Find Mike", "Buy eggs", "Destroy demogorgon","Fe", "Bgs", "Destrgon","Fie", "s", "Destroy demn","Find ", "Buy ", "demogorgon"]
    //And instead of having an array of hardcoded String objects I'm going to turn this item array into an array of item objects.
    var itemArray = [item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = item()
        newItem.title = "find Mike"
        itemArray.append(newItem)
        let newItem2 = item()
        newItem2.title = "find "
        itemArray.append(newItem2)
        let newItem3 = item()
        newItem3.title = "find bike"
        itemArray.append(newItem3)
   
        //We need to fix it in a couple of places because we're changing from an array of strings to an array of item objects.
      if let items =  defaults.array(forKey: "TodoListArray") as? [item]
      {
        itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

//MARK - Tableview Datasource Methods
    //what cells should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        //Ternary Operator
        //value = condition ? valueIfTrue : valueIfFalse
        //cell.accessoryType = item.done == true ? .checkmark : .none
        cell.accessoryType = item.done ? .checkmark : .none

//        if item.done == true
//        {
//             cell.accessoryType = .checkmark
//        }
//        else{
//             cell.accessoryType = .none
//        }
        return cell
    }
    
  //how many rows are wanted in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK - Tableview delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
      //  print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
//        if itemArray[indexPath.row].done == false{
//           itemArray[indexPath.row].done = true
//        }
//        else
//        {
//            itemArray[indexPath.row].done = false
//        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

// if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
// {
//
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//       else
//        {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
    }
//MARK - Add new items
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add new todey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert
            print("success")
            let newItem = item()
         newItem.title = textField.text!
            
         self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            //https://www.maketecheasier.com/view-library-folder-osx/
            

        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
}

