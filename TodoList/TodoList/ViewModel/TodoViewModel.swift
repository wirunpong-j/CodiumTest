//
//  TodoViewModel.swift
//  TodoList
//
//  Created by Wirunpong Jaingamlertwong on 8/5/2562 BE.
//  Copyright © 2562 Wirunpong Jaingamlertwong. All rights reserved.
//

import CoreData
import UIKit

class TodoViewModel {
    var context: NSManagedObjectContext!
    
    var todoList: [TodoCoreData] = []
    
    func addItem(message: String, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        let todo = TodoCoreData(context: context)
        todo.message = message
        todo.isChecked = false

        context.insert(todo)
        do {
            try context.save()
            completion()
        } catch {
            failure("Add error")
        }
    }
    
    func removeItem(index: Int, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        let todo = todoList[index]
        
        context.delete(todo)
        do {
            try context.save()
            completion()
        } catch {
            failure("Delete error")
        }
    }
    
    func updateItem(index: Int, completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        let todo = todoList[index]
        todo.isChecked = !todo.isChecked
        do {
            try context.save()
            print("Update Todo Success.")
            completion()
        } catch {
            failure("Update Todo error")
        }
    }
    
    func fetchAllTodo(completion: @escaping () -> (), failure: @escaping (String) -> ()) {
        let request: NSFetchRequest<TodoCoreData> = TodoCoreData.fetchRequest()
        do {
            let items = try context.fetch(request)
            self.todoList = items
            completion()
        } catch {
            failure("Fetch error")
        }
    }
}
