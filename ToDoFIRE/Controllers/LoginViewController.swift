//
//  ViewController.swift
//  ToDoFIRE
//
//  Created by Emil on 08.03.23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var warnLabel: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        
    }
    
    @objc func kbDidHide() {
        
    }

    @IBAction func loginTapped(_ sender: UIButton) {
    }
    @IBAction func registerTapped(_ sender: UIButton) {
    }
    
}

