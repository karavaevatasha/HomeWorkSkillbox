//
//  CoreDataModel.swift
//  Skillbox 14
//
//  Created by Nataliia on 21.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit
import CoreData

class CoreDataModel{
    
    static let shared = CoreDataModel()
    var context: NSManagedObjectContext!
    var toDoItems: [Task] = []
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getTask() -> [Task] {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            toDoItems = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return toDoItems
    }
    
    func saveTask(taskToDo: String, isDone: Bool){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        taskObject.isDone = isDone
        
        do {
            try context.save()
            toDoItems.append(taskObject)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(name: Task){
        let context = getContext()
        
        context.delete(name)
        
        do{
            try context.save()
        }
        catch let error as NSError {
            print("Error: \(error), description \(error.userInfo)")
        }
    }
    
    func changeState(editItem: Task, isDone: Bool) {
        let context = getContext()
        
        do{
            try context.save()
            editItem.isDone = isDone
        }
        catch let error as NSError {
            print("Error: \(error), description \(error.userInfo)")
        }
    }
}
