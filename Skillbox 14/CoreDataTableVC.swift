//
//  CoreDataTableVC.swift
//  Skillbox 14
//
//  Created by Nataliia on 20.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class CoreDataTableVC: UITableViewController {
    
    var toDoItems: [Task] = []
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "New task name"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){ (alert) in
        }
        let save = UIAlertAction(title: "Save", style: .default){ (alert) in
            let newItem = ac.textFields![0].text
            if newItem != "" {
                CoreDataModel.shared.saveTask(taskToDo: (newItem)!, isDone: false)
            }
            self.reloadData()
        }
        ac.addAction(cancel)
        ac.addAction(save)
        present(ac, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reloadData() {
        toDoItems = CoreDataModel.shared.getTask()
         self.tableView.setEditing(false, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.taskToDo
        cell.textLabel?.textColor = UIColor.darkGray
        
        if task.isDone  == true {
            cell.imageView?.image = UIImage(named: "check")
        } else {
            cell.imageView?.image = UIImage(named: "uncheck")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            CoreDataModel.shared.deleteTask(name: toDoItems[indexPath.row])
            reloadData()
        } else { return }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CoreDataModel.shared.changeState(editItem: toDoItems[indexPath.row], isDone: !toDoItems[indexPath.row].isDone)
        reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

