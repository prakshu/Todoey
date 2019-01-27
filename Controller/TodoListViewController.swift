//
//  ViewController.swift
//  Todoey
//
//  Created by Prakshi Bector on 7/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController
{
//    var itemArray = ["Find Mike", "Buy eggs", "Destroy demogorgon","Fe", "Bgs", "Destrgon","Fie", "s", "Destroy demn","Find ", "Buy ", "demogorgon"]
    //And instead of having an array of hardcoded String objects I'm going to turn this item array into an array of item objects.
  var itemArray = [Item]()
    var selectedCategory : Category?
    {
        // I can use a special keyword code did set and everything that's between these curly braces is going to happen as soon as selected category gets set with a value.This is the perfect place to call load items and we can delete it from our view.And control them using the data set to specify what should happen when a variable gets set with a new value.
        didSet
        {
            loadItems()
        }
    }
   // let defaults = UserDefaults.standard
//      let datafilePath = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context1 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
           print(FileManager.default.urls(for: .documentDirectory , in: .userDomainMask))
        //We're going to create a constant core data file path and this is going to be set to equal file manager which is the object that provides an interface to the file system.And then we're going to use the default file manager which is a shared file manager object.So does she now recognize is a singleton and this Singleton contains a whole bunch of url's and they're organized by directory and domain mask.
        let request : NSFetchRequest<Item> = Item.fetchRequest()

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
        context1.delete(itemArray[indexPath.row])

        itemArray.remove(at: indexPath.row)
        saveItems()
       // Now the order which you call these two methods one is removing the current item from the item array which is used to load up the table view data source and the other one is removing the data from permanentstores.
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
           // let newItem = item()
            //And inside this shared UI application object is something called delegate and this is the delegate ofthe app object.
            //So we create our new item and that item is an object of type and is managed object.So if you remember we said earlier on and has managed objects are essentially the roles that are inside your table and every single row will be an individual and as managed object.And then we fill up all of its fields.So the title field and the Dunfield and once we've done that we save our items on inside the save item'function.
            let newItem = Item(context: self.context1)
         newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
//        let encoder = PropertyListEncoder()

        do
        {
           try context1.save()
//            let data = try encoder.encode(self.itemArray)
//            try data.write(to: self.datafilePath!)
        }
        catch
        {
//            print("error encoding item array\(error)")
                    print("error saving context \(error)")

        }
        self.tableView.reloadData()

    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil)
        
      {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let addtionalPredicate = predicate
        {
   
        request.predicate =  NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        }
        else{
            request.predicate = categoryPredicate
        }
      // let request : NSFetchRequest<Item> = Item.fetchRequest()
        do
        {
   itemArray =    try context1.fetch(request)
        }
        catch
        {
            print("error fetching data from context \(error)")
        }
        self.tableView.reloadData()

       // But instead we're going to create a new constant called request and we're going to specify it's data type as an s fetch request that is going to fetch results in the form of items.
}
    
   
    
//    func loadItems()
//    {
//       if  let data = try? Data(contentsOf: datafilePath!)
//
//       {
//        let decoder = PropertyListDecoder()
//do
//      {
//        itemArray = try decoder.decode([item].self, from: data)
//        }
//     catch
//     {
//        print("Error decoding item array, \(error)")
//        }
//        }}
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
}
//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //So as always in order to read from the context we always have to create a request and we have to declare the request data type.So in this fetch request and it's going to return an array of items and we're going to set this to equalitem dot that's request.Now the next step is we have to specify what is going to be our filter right what is going to be ourquery.And we do that using something called an end as predicate.But before we do that let's first have a look at what is the data that we get back when the user clicks
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //because you're now typing in free text and in our case what we would do is we would say title we're going to look at the title attribute of each of our items in item array.And we're going to check that it contains a value.So this is the argument that we're going to substitute into this percentage sign.
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
    let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //a predicate is basically a foundation class that specifies how data should be fetched or filtered it's essentially a query language.
        // we can create a sort descriptor that is a N.S. sort descriptor and we can say that we want to sortusing the key that's the titles of each of the items and we can sort it in alphabetical order by saying
          request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        print(searchBar.text!)
       loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {

            loadItems()
            //So the dispatch queue is that manager who assigns these projects to different threads.And we're going to ask it to grab us the main thread.And this is where you should be updating your user interface elements.
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        }
    }
    
    
}

