//
//  TableViewController.swift
//  HelloApp
//
//  Created by Aleksander Waage on 23/06/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var hellos: [Hello] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Hello App"
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let hellos = try? context.fetch(Hello.fetchRequest()) as? [Hello]{
                self.hellos = hellos
                print("Hellos: \(hellos)")
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func addHello(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newHello = Hello(context: context)
            newHello.text = "Hello!"
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            loadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return hellos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = hellos[indexPath.row].text
        print("Making a cell")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(hellos[indexPath.row])
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            loadData()
        }
    }




}
