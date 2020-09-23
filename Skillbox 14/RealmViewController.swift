//
//  RealmViewController.swift
//  Skillbox 14
//
//  Created by Nataliia on 20.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class RealmViewController: UIViewController {
    
    var todo = [ToDoItems]()
    var isEditingMode = false
    
    @IBOutlet var todoTableView: UITableView!
    @IBAction func newToDo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
        todoTableView.delegate = self
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reload() {
        todo = RealmModel.shared.getAllItems()
        self.todoTableView.setEditing(false, animated: true)
        todoTableView.reloadData()
    }
}

extension RealmViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue", let dvc = segue.destination as? InsertToDoItemsVC {
            if let item = sender as? ToDoItems {
                dvc.item = item
            }
        }
    }
}

extension RealmViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return RealmModel.shared.getAllItems().count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        cell.todoText.text = todo[indexPath.row].ToDoText
        cell.isDoneText.text = todo[indexPath.row].IsDone ? "It's done" : "Do it"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RealmModel.shared.deleteItem(name: RealmModel.shared.getAllItems()[indexPath.row])
            reload()
        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RealmModel.shared.updateTask(editItem: todo[indexPath.row], isDone: !todo[indexPath.row].IsDone)
        reload()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
