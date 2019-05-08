//
//  TodoListCell.swift
//  TodoList
//
//  Created by Wirunpong Jaingamlertwong on 8/5/2562 BE.
//  Copyright © 2562 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class TodoListCell: UITableViewCell {
    static let identifier = "TodoListCell"

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    func setUpCell(todo: TodoCoreData) {
        todoLabel.text = todo.message
        checkImageView.isHidden = !todo.isChecked
    }

}
