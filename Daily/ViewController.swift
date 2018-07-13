//
//  ViewController.swift
//  Daily
//
//  Created by Ken Zheng on 7/10/18.
//  Copyright © 2018 Ken Zheng. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: ReusableView {
}

class ViewController: UITableViewController {
    var dailyItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Daily"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.defaultReuseIdentifier)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addButtonTapped(_ sender:UIBarButtonItem!) {
        let ac = UIAlertController(title: nil, message: "What did you do today?", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action: UIAlertAction) -> Void in
            let dailyTextField = ac.textFields![0] as UITextField
            
            self.dailyItems.append(dailyTextField.text!)
            self.tableView!.reloadData()
            })
        addAction.isEnabled = false
        ac.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        ac.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Fixed a bug"
            
            NotificationCenter.default.addObserver(forName: Notification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main, using: { (notification) in
                addAction.isEnabled = textField.text != ""
            })
        })
        
        self.present(ac, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.defaultReuseIdentifier, for: indexPath)
        cell.textLabel!.text = self.dailyItems[indexPath.row]
        return cell
    }
}
