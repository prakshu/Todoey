//
//  ViewController.swift
//  Todoey
//
//  Created by Prakshi Bector on 7/1/19.
//  Copyright © 2019 Prakshi Bector. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
let itemArray = ["Find Mike", "Buy eggs", "Destroy demogorgon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//MARK - Tableview Datasource Methods
    //what cells should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
  //how many rows are wanted in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK - Tableview delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
       // if tableView.sel
 if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
 {
     
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
       else
        {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }

 
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
}

