# Codable-Database-Swift
Xcode 12.4
Swift 5

Example of Codable data to show list of items and option to add items

Sample code

let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")


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
    
    
