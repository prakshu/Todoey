//
//  ViewController.swift
//  Todoey
//
//  Created by Prakshi Bector on 7/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController
{
//    var itemArray = ["Find Mike", "Buy eggs", "Destroy demogorgon","Fe", "Bgs", "Destrgon","Fie", "s", "Destroy demn","Find ", "Buy ", "demogorgon"]
    //And instead of having an array of hardcoded String objects I'm going to turn this item array into an array of item objects.
  var todoItems: Results<Item>?
    let realm = try! Realm()

    var selectedCategory : Category?
    {
      didSet
        {
           loadItems()
        }
    }
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
           print(FileManager.default.urls(for: .documentDirectory , in: .userDomainMask))
        //We're going to create a constant core data file path and this is going to be set to equal file manager which is the object that provides an interface to the file system.And then we're going to use the default file manager which is a shared file manager object.So does she now recognize is a singleton and this Singleton contains a whole bunch of url's and they're organized by directory and domain mask.
      //  let request : NSFetchRequest<Item> = Item.fetchRequest()

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
      if  let item = todoItems?[indexPath.row]
      {
        cell.textLabel?.text = item.title
    
        cell.accessoryType = item.done ? .checkmark : .none
        }
        else
      {        cell.textLabel?.text = "No Items Added"
        
        
        }


        return cell
    }
    
  //how many rows are wanted in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todoItems?.count ?? 1
    }
    //MARK - Tableview delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //And if this is not nil then we're going to be have to access this item object and we can say try Romdot right.
        if let item = todoItems?[indexPath.row]
        {
            do{
                
            try realm.write {
                realm.delete(item)
//                item.done = !item.done
            }
            }
            catch
            {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
//      //  print(itemArray[indexPath.row])
//        todoItems[indexPath.row].done = !itemArray[indexPath.row].done
//      //  context1.delete(itemArray[indexPath.row])
//
//        todoItems.remove(at: indexPath.row)
//        saveItems()
//
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
        
        { (action)
            in
           if let currentCategory = self.selectedCategory
           {
       
            do
            {
                try self.realm.write
                {
                    let newItem = Item()
                    newItem.title = textField.text!
                    let date = Date()
                    
//                    let result = formatter.string(from: date)
                    newItem.dateCreated = date
           currentCategory.items.append(newItem)
                }
                
            }
            catch
            {
                print("error saving context \(error)")
                
            }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    func saveItems()
//    {
////        let encoder = PropertyListEncoder()
//
//        do
//        {
//           try context1.save()
////            let data = try encoder.encode(self.itemArray)
////            try data.write(to: self.datafilePath!)
//        }
//        catch
//        {
////            print("error encoding item array\(error)")
//                    print("error saving context \(error)")
//
//        }
//        self.tableView.reloadData()
//
//    }
    
    func loadItems()

      {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
       
     
        self.tableView.reloadData()

       // But instead we're going to create a new constant called request and we're going to specify it's data type as an s fetch request that is going to fetch results in the form of items.
}

//
//
////    func loadItems()
////    {
////       if  let data = try? Data(contentsOf: datafilePath!)
////
////       {
////        let decoder = PropertyListDecoder()
////do
////      {
////        itemArray = try decoder.decode([item].self, from: data)
////        }
////     catch
////     {
////        print("Error decoding item array, \(error)")
////        }
////        }}
//
//    //    func numberOfSections(in tableView: UITableView) -> Int {
////
////    }
//}
}
//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate
{
 
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
        {
//            todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "title", ascending: true)

 todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "dateCreated", ascending: true)
            self.tableView.reloadData()

        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {

            //So the dispatch queue is that manager who assigns these projects to different threads.And we're going to ask it to grab us the main thread.And this is where you should be updating your user interface elements.
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        }
    }
    
    
    
}

