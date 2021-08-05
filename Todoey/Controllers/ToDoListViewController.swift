//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var array :[ToDoItem] = []
    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
   // let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        print(dataPath)
                
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let itemCell = array[indexPath.row]
        cell.textLabel?.text = itemCell.name
        //Ternary operator ==>
        //value = condition ? valueIfTrue: valueIfFalse
        cell.accessoryType = itemCell.isChecked ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        array[indexPath.row].isChecked = !array[indexPath.row].isChecked
        self.saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addBarItemClicked(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // do your functionality
            let value = textField.text!
            let toDoItem = ToDoItem()
            toDoItem.name = value
            toDoItem.isChecked = false
            self.array.append(toDoItem)
            self.saveItems()
            alert.dismiss(animated: true, completion: nil)
            
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Create new item"
            textField = textfield
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
        let data = try encoder.encode(self.array)
            try data.write(to: self.dataPath!)
        } catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataPath!){
            let decoder = PropertyListDecoder()
            do {
            array = try decoder.decode([ToDoItem].self, from: data)
            }
            catch{
                print(error)
            }
            
        }
    }
}

