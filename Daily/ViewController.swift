//
//  ViewController.swift
//  Daily
//
//  Created by Ken Zheng on 7/10/18.
//  Copyright © 2018 Ken Zheng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Daily"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.addButtonTapped(_:)))
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
            
            print(dailyTextField.text!)
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
}
