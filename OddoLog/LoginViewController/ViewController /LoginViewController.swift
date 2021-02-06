//
//  LoginViewController.swift
//  OddoLog
//
//  Created by Petr on 31.01.2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginViewBottomConstrain: NSLayoutConstraint!
    var presenter: LoginPresenter = LoginViewPresenter()
    @IBOutlet var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        loginViewBottomConstrain.constant = 300
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @IBAction func loginIn(_ sender: Any) {
        emailTextFiled.resignFirstResponder()
        passwordTextFiled.resignFirstResponder()
        presenter.setUserName(username: emailTextFiled.text)
        presenter.setPassword(password: passwordTextFiled.text)
        presenter.loginIn()
    }
    // MARK: - Notification action
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            loginViewBottomConstrain.constant = keyboardHeight / 2
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let _: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            loginViewBottomConstrain.constant = 0
            view.layoutIfNeeded()
        }
    }
}

extension LoginViewController: LoginView {
    // ???
    func didLogin(error: Error?) {
        if error == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.showAlert(with: nil, message: error?.localizedDescription ?? "Something was wrong")
        }
    }
    func showAlert(with title: String?, message: String?) {
        self.presentAlert(withTitle: title, message: message)
    }
    
    func enableSubmitButton(_ isEnabled: Bool) {
        self.logInButton.isEnabled = isEnabled
        self.logInButton.setTitle(isEnabled ? "Submit" : "Submitting...", for: .normal)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == emailTextFiled {
            presenter.setUserName(username: textField.text)
        }
        
        if textField == passwordTextFiled {
            presenter.setPassword(password: textField.text)
        }
        
        presenter.loginIn()
        
        return true
    }
    
}
