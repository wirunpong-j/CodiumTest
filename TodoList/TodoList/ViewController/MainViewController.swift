//
//  ViewController.swift
//  TodoList
//
//  Created by Wirunpong Jaingamlertwong on 8/5/2562 BE.
//  Copyright © 2562 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = TodoViewModel()
    let CELL_HEIGHT: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCoreData()
        self.setUpTableView()
    }
    
    private func setUpCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        viewModel.context = context
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchAllTodo(completion: {
            self.tableView.reloadData()
        }) { (error) in
            self.showAlert(message: error)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    private func showTextFieldAlert() {
        let alert = UIAlertController(title: "ToDo", message: "Please enter todo.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let addAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let textField = alert.textFields?[0] {
                let message = textField.text ?? "-"
                
                self.viewModel.addItem(message: message, completion: {
                    self.fetchData()
                }, failure: { (error) in
                    self.showAlert(message: error)
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.showTextFieldAlert()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateItem(index: indexPath.row, completion: {
            if let cell = tableView.cellForRow(at: indexPath) as? TodoListCell {
                cell.setUpCell(todo: self.viewModel.todoList[indexPath.row])
            }
        }) { (error) in
            self.showAlert(message: error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.identifier) as? TodoListCell {
            cell.setUpCell(todo: viewModel.todoList[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.removeItem(index: indexPath.row, completion: {
                self.fetchData()
            }) { (error) in
                self.showAlert(message: error)
            }
        default:
            break
        }
    }
}

