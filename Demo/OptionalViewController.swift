//
//  OptionalViewController.swift
//  FormCell
//
//  Created by 須藤 将史 on 2017/02/20.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import FormCell

private struct User {
    
    var name: String!
    var email: String!
    var tel: String!
    
    init(name: String, email: String, tel: String) {
        self.name = name
        self.email = email
        self.tel = tel
    }
}

final class OptionalViewController: UITableViewController {
    
    private var user: User = User(name: "", email: "", tel: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "All-Optional-Forms"
        self.tableView = UITableView.init(frame: self.view.frame, style: .grouped)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "user name"
        case 1:
            return "user email"
        case 2:
            return "user phone number"
        default:
            break
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = FormFieldCell(isOptional: true)
            cell.editField(beginEditing: nil, textChanged: { (text) in
                self.user.name = text
            }, didReturn: { 
                if let cell = tableView.cellForRow(at: indexPath) as? FormFieldCell {
                    cell.textField.resignFirstResponder()
                }
            })
            
            cell.textField.keyboardType = .default
            cell.textField.placeholder = "enter your name"
            cell.textField.text = self.user.name
            return cell
            
        case 1:
            
            let cell = FormFieldCell(pregError: (.email, nil), isOptional: true)
            cell.editField(beginEditing: nil, textChanged: { (text) in
                self.user.email = text
            }, didReturn: {
                if let cell = tableView.cellForRow(at: indexPath) as? FormFieldCell {
                    cell.textField.resignFirstResponder()
                }
            })
            
            cell.textField.keyboardType = .emailAddress
            cell.textField.placeholder = "enter your email"
            cell.textField.text = self.user.email
            return cell
            
        case 2:
            
            let cell = FormFieldCell(lengthError: (0, 11), pregError: (.phone, nil), isOptional: true)
            cell.editField(beginEditing: nil, textChanged: { (text) in
                self.user.tel = text
            }, didReturn: { 
                if let cell = tableView.cellForRow(at: indexPath) as? FormFieldCell {
                    cell.textField.resignFirstResponder()
                }
            })
            
            cell.textField.keyboardType = .numberPad
            cell.textField.placeholder = "enter your phone number"
            cell.textField.text = self.user.tel
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
