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
   // let defaults = UserDefaults.standard
      let datafilePath = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //We're going to create a constant core data file path and this is going to be set to equal file manager which is the object that provides an interface to the file system.And then we're going to use the default file manager which is a shared file manager object.So does she now recognize is a singleton and this Singleton contains a whole bunch of url's and they're organized by directory and domain mask.
      loadItems()
        //print(datafilePath)
//        let newItem = item()
//        newItem.title = "find Mike"
//        itemArray.append(newItem)
//        let newItem2 = item()
//        newItem2.title = "find "
//        itemArray.append(newItem2)
//        let newItem3 = item()
//        newItem3.title = "find bike"
//        itemArray.append(newItem3)
//
        //We need to fix it in a couple of places because we're changing from an array of strings to an array of item objects.
//      if let items =  defaults.array(forKey: "TodoListArray") as? [item]
//      {
//        itemArray = items
//        }
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
        saveItems()
        
//        if itemArray[indexPath.row].done == false{
//           itemArray[indexPath.row].done = true
//        }
//        else
//        {
//            itemArray[indexPath.row].done = false
//        }
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
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add new todey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default)
        
        { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert
            print("success")
            let newItem = item()
         newItem.title = textField.text!
            self.itemArray.append(newItem)
     self.saveItems()
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //https://www.maketecheasier.com/view-library-folder-osx/
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()

        do
        {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.datafilePath!)
        }
        catch
        {
            print("error encoding item array\(error)")
        }
        self.tableView.reloadData()

    }
    
    func loadItems()
    {
       if  let data = try? Data(contentsOf: datafilePath!)
       
       {
        let decoder = PropertyListDecoder()
do
      {
        itemArray = try decoder.decode([item].self, from: data)
        }
     catch
     {
        print("Error decoding item array, \(error)")
        }
        }}
        
    //    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
}

