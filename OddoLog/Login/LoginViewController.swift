//
//  LoginViewController.swift
//  OddoLog
//
//  Created by Petr on 31.01.2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter!
    
    @IBOutlet var emailTextFiled: UIView!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func loginIn(_ sender: Any) {
        presenter?.loginTapped()
    
    }
    
}
