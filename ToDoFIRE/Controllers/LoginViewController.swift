//
//  ViewController.swift
//  ToDoFIRE
//
//  Created by Emil on 08.03.23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        prepareUI()
        CheckIfUserLogged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func prepareUI() {
        
        warnLabel.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func CheckIfUserLogged() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != ""
            else {
                displayWarningLabel(withText: "Info is incorrect")
                return
            }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "Such user does not exist")
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != ""
            else {
                displayWarningLabel(withText: "Info is incorrect")
                return
            }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            
            guard error == nil, user != nil else { print(error!.localizedDescription); return }
            
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email": user?.user.email])
        }
    }
    
}

